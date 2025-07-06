import 'dart:convert';
import 'dart:io';
import 'package:fast2mine_challenge/core/assets/assets.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/ciclo.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/sensor_input.dart';
import 'package:fast2mine_challenge/features/home_page/domain/usecases/create_or_update_ciclo_usecase.dart';
import 'package:fast2mine_challenge/features/home_page/domain/usecases/get_unsynchronized_ciclos_usecase.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class HomeController {
  late RxList<SensorInput> _simulations;
  late RxList<Ciclo> _completeCycles;
  late Rxn<SensorInput> _currentSimulation;
  late RxString _currentStatus;
  late ICreateOrUpdateCicloUsecase _createOrUpdateCicloUsecase;
  late IGetUnsynchronizedCiclosUsecase _getUnsynchronizedCiclosUsecase;
  int indexSimulation = -1;

  HomeController() {
    _simulations = RxList();
    _completeCycles = RxList();
    _currentSimulation = Rxn();
    _currentStatus = RxString('-----');
    _createOrUpdateCicloUsecase = CreateOrUpdateCicloUsecase();
    _getUnsynchronizedCiclosUsecase = GetUnsynchronizedCiclosUsecase();
    loadSimulation();
  }

  //Getter
  List<SensorInput> get simulations => _simulations;
  List<Ciclo> get completeCycles => _completeCycles;
  SensorInput? get currentSimulation => _currentSimulation.value;
  String get currentStatus => _currentStatus.value;
  String get equipmentLoad => currentSimulation?.equipamentoCarga ?? '-----';
  String get tippingX =>
      currentSimulation?.pontoBasculamento.x.toString() ?? '-----';
  String get tippingY =>
      currentSimulation?.pontoBasculamento.y.toString() ?? '-----';
  String get tippingPoint => 'X: $tippingX | Y : $tippingY';
  String get currentSpeed => currentSimulation?.gps != null
      ? '${(currentSimulation!.gps.velocidadeConvertida).toString()} km/h'
      : '-----';

  //Setter
  set simulations(List<SensorInput> value) => _simulations.value = value;
  set completeCycles(List<Ciclo> value) => _completeCycles.value = value;
  set currentSimulation(SensorInput? value) => _currentSimulation.value = value;

  Future<void> loadSimulation() async {
    final json = await rootBundle.loadString(simulacaoJson);
    final jsonLines = LineSplitter.split(json).toList();
    simulations =
        jsonLines.map((e) => SensorInput.fromJson(jsonDecode(e))).toList();
  }

  void simulate(BuildContext context) {
    indexSimulation++;
    if (simulations[indexSimulation] == null) {
      var restart = false;
      openPopup(
        context,
        text: '🚚 Fim da simulação. \n🔁 Deseja reiniciar a simulação?',
        buttonConfirmText: 'SIM',
        onPressedConfirm: () => restart = true,
        buttonCancelText: 'NÃO',
        onPressedCancel: () => restart = false,
      );
      if (!restart) return;
      indexSimulation = 0;
    }

    currentSimulation = simulations[indexSimulation];
  }

  Future<void> saveCiclo(Ciclo item) async {
    try {
      final response = await _createOrUpdateCicloUsecase.call(item);
      if (!response) throw Exception();
    } catch (_) {}
  }

  Future<void> syncData(BuildContext context) async {
    final completeCycles = await _getUnsynchronizedCiclosUsecase.call();
    if (completeCycles.isEmpty) {
      if (context.mounted) {
        openPopup(
          context,
          text: 'TODOS OS CICLOS JÁ FORAM SINCRONIZADOS',
          buttonConfirmText: 'OK',
        );
      }
      return;
    }

    final syncCiclos = completeCycles.map((ciclo) {
      final cicloSincronizado = ciclo;
      cicloSincronizado.statusSincronizacao = 'SINCRONIZADO';
      return cicloSincronizado;
    }).toList();

    const encoder = JsonEncoder.withIndent('  ');
    final formattedJson =
        encoder.convert(syncCiclos.map((c) => c.toJson()).toList());

    final path = '/storage/emulated/0/Download/sync_servidor.jsonl';
    final file = File(path);
    await file.writeAsString(formattedJson);

    for (final ciclo in syncCiclos) {
      await _createOrUpdateCicloUsecase.call(ciclo);
    }
    if (context.mounted) {
      openPopup(
        context,
        text: 'SINCRONISMO REALIZADO COM SUCESSO',
        buttonConfirmText: 'OK',
      );
    }
  }
}

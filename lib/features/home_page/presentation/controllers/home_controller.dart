import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:diacritic/diacritic.dart';
import 'package:fast2mine_challenge/core/assets/assets.dart';
import 'package:fast2mine_challenge/core/utils/converters.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/ciclo.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/coordenadas.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/etapa.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/sensor_input.dart';
import 'package:fast2mine_challenge/features/home_page/domain/usecases/create_or_update_ciclo_usecase.dart';
import 'package:fast2mine_challenge/features/home_page/domain/usecases/get_unsynchronized_ciclos_usecase.dart';
import 'package:fast2mine_challenge/features/home_page/presentation/widgets/popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController {
  late RxList<SensorInput> _simulations;
  late RxList<Ciclo> _completeCycles;
  late Rxn<SensorInput> _currentSimulation;
  late RxString _currentStatus;
  late ICreateOrUpdateCicloUsecase _createOrUpdateCicloUsecase;
  late IGetUnsynchronizedCiclosUsecase _getUnsynchronizedCiclosUsecase;
  int indexSimulation = -1;
  DateTime? stopTime;
  Duration stoppedTime = Duration(seconds: 0);
  List<Etapa> steps = [];

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
  List<Ciclo> get unsynchronizedCicles => _completeCycles;
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
  set unsynchronizedCicles(List<Ciclo> value) => _completeCycles.value = value;
  set currentSimulation(SensorInput? value) => _currentSimulation.value = value;
  set currentStatus(String value) => _currentStatus.value = value;

  Future loadSimulation() async {
    final json = await rootBundle.loadString(simulacaoJson);
    final jsonLines = LineSplitter.split(json).toList();
    simulations =
        jsonLines.map((e) => SensorInput.fromJson(jsonDecode(e))).toList();
  }

  Future simulate(BuildContext context) async {
    indexSimulation++;

    if (indexSimulation >= simulations.length) {
      var restart = false;
      await openPopup(
        context,
        text: '🚚 Fim da simulação. \n\n Deseja reiniciar a simulação?',
        buttonConfirmText: 'SIM',
        onPressedConfirm: () {
          restart = true;
          Navigator.pop(context);
        },
        buttonCancelText: 'NÃO',
        onPressedCancel: () {
          restart = false;
          Navigator.pop(context);
        },
      );
      if (!restart) return;
      indexSimulation = 0;
      steps.clear();
      stopTime = null;
      stoppedTime = Duration(seconds: 0);
    }

    currentSimulation = simulations[indexSimulation];
    validateCurrentStatus();

    final step = removeDiacritics(currentStatus.replaceAll(' ', '_'));
    if (!steps.map((e) => e.etapa).contains(step)) {
      steps.add(Etapa(step, currentSimulation!.dataHora));
    }

    final fullCicle = validateFullCicle();
    if (fullCicle) {
      final truckId = currentSimulation!.beacons
          .firstWhere((e) => e.tipo == 'sensor_bascula')
          .id;

      final ciclo = Ciclo(
        'ciclo_${steps.first.timestamp.toIso8601String()}_${steps.last.timestamp.toIso8601String()}',
        steps.first.timestamp,
        steps.last.timestamp,
        steps,
        truckId,
        currentSimulation!.equipamentoCarga,
        currentSimulation!.pontoBasculamento,
        'NÃO SINCRONIZADO',
      );

      await _createOrUpdateCicloUsecase.call(ciclo);
      steps.clear();
    }
    unsynchronizedCicles = await _getUnsynchronizedCiclosUsecase.call();
  }

  void validateCurrentStatus() {
    final speed = currentSimulation!.gps.velocidade;

    if (speed == 0) {
      stopTime ??= currentSimulation!.dataHora;
      stoppedTime = currentSimulation!.dataHora.difference(stopTime!);
    } else {
      stopTime = null;
      stoppedTime = Duration(seconds: 0);
    }

    final otherTruckLoading = hasBeacon(
          'caminhao',
          status: 'EM_CARREGAMENTO',
          equipamentoCarga: currentSimulation!.equipamentoCarga,
        ) ||
        hasBeacon(
          'caminhao',
          status: 'EM_FILA_CARREGAMENTO',
          equipamentoCarga: currentSimulation!.equipamentoCarga,
        );

    final isNearExcavator = hasBeacon('escavadeira', status: 'OPERANDO');

    final isLoadingTruck = hasBeacon(
      'escavadeira',
      distancia: 2,
    );

    final otherTruckInLineTipping = hasBeacon(
      'caminhao',
      status: 'EM_FILA_BASCULAMENTO',
    );

    final tippingSensorOn = hasBeacon(
      'sensor_bascula',
      status: 'ATIVADO',
    );

    final isNearTippingPoint = nearTippingPoint(
      currentSimulation!.gps.localizacao,
      currentSimulation!.pontoBasculamento,
    );

    if (otherTruckLoading && isNearExcavator) {
      currentStatus = 'EM FILA CARREGAMENTO';
      return;
    }

    if (stoppedTime >= Duration(seconds: 5)) {
      if (otherTruckLoading) {
        currentStatus = 'EM FILA CARREGAMENTO';
        return;
      }

      if (isLoadingTruck && !otherTruckLoading) {
        currentStatus = 'EM CARREGAMENTO';
        return;
      }

      if (isNearTippingPoint &&
          !tippingSensorOn &&
          (otherTruckInLineTipping || currentStatus == 'TRÂNSITO CHEIO')) {
        currentStatus = 'EM FILA BASCULAMENTO';
        return;
      }
    }

    bool isAtTippingPoint = isNearTippingPoint && tippingSensorOn;

    if (speed == 0) {
      if (isAtTippingPoint) {
        currentStatus = 'EM BASCULAMENTO';
        return;
      }
    }

    if (speed > 0) {
      if (!isLoadingTruck && currentStatus == 'EM CARREGAMENTO') {
        currentStatus = 'TRÂNSITO CHEIO';
        return;
      }

      if (!isNearTippingPoint && currentStatus == 'EM BASCULAMENTO') {
        currentStatus = 'TRÂNSITO VAZIO';
        return;
      }
    }
  }

  bool validateFullCicle() {
    final stepsString = steps.map((e) => e.etapa).join(";");
    return stepsString ==
        "EM_FILA_CARREGAMENTO;EM_CARREGAMENTO;TRANSITO_CHEIO;EM_FILA_BASCULAMENTO;EM_BASCULAMENTO;TRANSITO_VAZIO";
  }

  bool hasBeacon(
    String tipo, {
    String? status,
    String? equipamentoCarga,
    double? distancia,
  }) {
    return currentSimulation!.beacons.firstWhereOrNull(
          (e) =>
              e.tipo == tipo &&
              (status == null || e.status == status) &&
              (equipamentoCarga == null ||
                  e.equipamentoCarga == equipamentoCarga) &&
              (distancia == null || e.distancia < distancia),
        ) !=
        null;
  }

  bool nearTippingPoint(Coordenadas current, Coordenadas tippingPoint) {
    final distance = sqrt(
      pow(current.x - tippingPoint.x, 2) + pow(current.y - tippingPoint.y, 2),
    );
    return distance < 5;
  }

  Future syncData(BuildContext context) async {
    if (unsynchronizedCicles.isEmpty) {
      if (context.mounted) {
        openPopup(
          context,
          text: 'TODOS OS CICLOS JÁ FORAM SINCRONIZADOS',
          buttonConfirmText: 'OK',
        );
      }
      return;
    }

    final syncCiclos = unsynchronizedCicles.map((ciclo) {
      final cicloSincronizado = ciclo;
      cicloSincronizado.statusSincronizacao = 'SINCRONIZADO';
      return cicloSincronizado;
    }).toList();

    const encoder = JsonEncoder.withIndent('  ');
    final formattedJson =
        encoder.convert(syncCiclos.map((c) => c.cicloToJsonSync()).toList());

    final path = '/storage/emulated/0/Download/sync_servidor.jsonl';
    final file = File(path);

    if (await file.exists()) file.delete();
    await file.writeAsString(formattedJson);

    for (final ciclo in syncCiclos) {
      await _createOrUpdateCicloUsecase.call(ciclo);
    }
    unsynchronizedCicles.clear();

    if (context.mounted) {
      openPopup(
        context,
        text: 'SINCRONISMO REALIZADO COM SUCESSO',
        buttonConfirmText: 'OK',
      );
    }
  }
}

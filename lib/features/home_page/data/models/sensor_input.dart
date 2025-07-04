import 'package:fast2mine_challenge/features/home_page/data/models/beacons.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/coordenadas.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/gps.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sensor_input.g.dart';

@JsonSerializable()
class SensorInput {
  @JsonKey(name: 'data_hora')
  final DateTime dataHora;
  @JsonKey(name: 'equipamento_carga')
  final String equipamentoCarga;
  @JsonKey(name: 'ponto_basculamento')
  final Coordenadas pontoBasculamento;
  @JsonKey(name: 'beacons')
  final List<Beacons> beacons;
  @JsonKey(name: 'gps')
  final GPS gps;

  SensorInput(
    this.dataHora,
    this.equipamentoCarga,
    this.pontoBasculamento,
    this.beacons,
    this.gps,
  );

  factory SensorInput.fromJson(Map<String, dynamic> json) =>
      _$SensorInputFromJson(json);

  Map<String, dynamic> toJson() => _$SensorInputToJson(this);
}

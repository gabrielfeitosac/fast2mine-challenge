import 'package:json_annotation/json_annotation.dart';

part 'beacons.g.dart';

@JsonSerializable()
class Beacons {
  final String id;
  final String tipo;
  final double distancia;
  final String status;
  @JsonKey(name: 'equipamento_carga')
  final String? equipamentoCarga;

  Beacons(
    this.id,
    this.tipo,
    this.distancia,
    this.status,
    this.equipamentoCarga,
  );

  factory Beacons.fromJson(Map<String, dynamic> json) =>
      _$BeaconsFromJson(json);

  Map<String, dynamic> toJson() => _$BeaconsToJson(this);
}

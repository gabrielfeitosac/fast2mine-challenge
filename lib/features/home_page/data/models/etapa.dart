import 'package:json_annotation/json_annotation.dart';

part 'etapa.g.dart';

@JsonSerializable()
class Etapa {
  final String etapa;
  final DateTime timestamp;

  Etapa(
    this.etapa,
    this.timestamp,
  );

  factory Etapa.fromJson(Map<String, dynamic> json) => _$EtapaFromJson(json);

  Map<String, dynamic> toJson() => _$EtapaToJson(this);
}

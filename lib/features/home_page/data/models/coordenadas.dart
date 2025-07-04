import 'package:json_annotation/json_annotation.dart';

part 'coordenadas.g.dart';

@JsonSerializable()
class Coordenadas {
  final int x;
  final int y;
  final int z;

  Coordenadas(
    this.x,
    this.y,
    this.z,
  );

  factory Coordenadas.fromJson(Map<String, dynamic> json) =>
      _$CoordenadasFromJson(json);

  Map<String, dynamic> toJson() => _$CoordenadasToJson(this);
}

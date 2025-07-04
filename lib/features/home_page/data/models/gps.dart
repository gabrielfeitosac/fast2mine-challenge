import 'package:fast2mine_challenge/features/home_page/data/models/coordenadas.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gps.g.dart';

@JsonSerializable()
class GPS {
  final double velocidade;
  final Coordenadas localizacao;

  GPS(
    this.velocidade,
    this.localizacao,
  );

  factory GPS.fromJson(Map<String, dynamic> json) => _$GPSFromJson(json);

  Map<String, dynamic> toJson() => _$GPSToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorInput _$SensorInputFromJson(Map<String, dynamic> json) => SensorInput(
      DateTime.parse(json['data_hora'] as String),
      json['equipamento_carga'] as String,
      Coordenadas.fromJson(json['ponto_basculamento'] as Map<String, dynamic>),
      (json['beacons'] as List<dynamic>)
          .map((e) => Beacons.fromJson(e as Map<String, dynamic>))
          .toList(),
      GPS.fromJson(json['gps'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SensorInputToJson(SensorInput instance) =>
    <String, dynamic>{
      'data_hora': instance.dataHora.toIso8601String(),
      'equipamento_carga': instance.equipamentoCarga,
      'ponto_basculamento': instance.pontoBasculamento,
      'beacons': instance.beacons,
      'gps': instance.gps,
    };

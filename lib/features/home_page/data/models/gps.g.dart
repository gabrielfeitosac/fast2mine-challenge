// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GPS _$GPSFromJson(Map<String, dynamic> json) => GPS(
      (json['velocidade'] as num).toDouble(),
      Coordenadas.fromJson(json['localizacao'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GPSToJson(GPS instance) => <String, dynamic>{
      'velocidade': instance.velocidade,
      'localizacao': instance.localizacao,
    };

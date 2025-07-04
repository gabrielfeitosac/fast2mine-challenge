// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'etapa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Etapa _$EtapaFromJson(Map<String, dynamic> json) => Etapa(
      json['etapa'] as String,
      DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$EtapaToJson(Etapa instance) => <String, dynamic>{
      'etapa': instance.etapa,
      'timestamp': instance.timestamp.toIso8601String(),
    };

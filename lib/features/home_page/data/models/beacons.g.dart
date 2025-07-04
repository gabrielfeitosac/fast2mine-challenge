// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beacons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Beacons _$BeaconsFromJson(Map<String, dynamic> json) => Beacons(
      json['id'] as String,
      json['tipo'] as String,
      (json['distancia'] as num).toDouble(),
      json['status'] as String,
      json['equipamento_carga'] as String?,
    );

Map<String, dynamic> _$BeaconsToJson(Beacons instance) => <String, dynamic>{
      'id': instance.id,
      'tipo': instance.tipo,
      'distancia': instance.distancia,
      'status': instance.status,
      'equipamento_carga': instance.equipamentoCarga,
    };

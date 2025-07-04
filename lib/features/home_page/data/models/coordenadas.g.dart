// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordenadas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coordenadas _$CoordenadasFromJson(Map<String, dynamic> json) => Coordenadas(
      (json['x'] as num).toInt(),
      (json['y'] as num).toInt(),
      (json['z'] as num).toInt(),
    );

Map<String, dynamic> _$CoordenadasToJson(Coordenadas instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
    };

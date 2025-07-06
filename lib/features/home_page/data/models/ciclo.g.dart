// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ciclo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ciclo _$CicloFromJson(Map<String, dynamic> json) => Ciclo(
      json['ciclo_id'] as String,
      DateTime.parse(json['data_inicio'] as String),
      DateTime.parse(json['data_fim'] as String),
      etapasFromJsonString(json['etapas'] as String),
      json['equipamento_id'] as String,
      json['equipamento_carga'] as String,
      coordenadasFromJsonString(json['ponto_basculamento'] as String),
      json['status_sincronizacao'] as String,
    );

Map<String, dynamic> _$CicloToJson(Ciclo instance) => <String, dynamic>{
      'ciclo_id': instance.cicloId,
      'data_inicio': instance.dataInicio.toIso8601String(),
      'data_fim': instance.dataFim.toIso8601String(),
      'etapas': etapasToJsonString(instance.etapas),
      'equipamento_id': instance.equipamentoId,
      'equipamento_carga': instance.equipamentoCarga,
      'ponto_basculamento': coordenadasToJsonString(instance.pontoBasculamento),
      'status_sincronizacao': instance.statusSincronizacao,
    };

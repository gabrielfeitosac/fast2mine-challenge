// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ciclo_completo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CicloCompleto _$CicloCompletoFromJson(Map<String, dynamic> json) =>
    CicloCompleto(
      json['ciclo_id'] as String,
      DateTime.parse(json['data_inicio'] as String),
      DateTime.parse(json['data_fim'] as String),
      (json['etapas'] as List<dynamic>)
          .map((e) => Etapa.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['equipamento_id'] as String,
      json['equipamento_carga'] as String,
      Coordenadas.fromJson(json['ponto_basculamento'] as Map<String, dynamic>),
      json['sincronizado'] as bool,
    );

Map<String, dynamic> _$CicloCompletoToJson(CicloCompleto instance) =>
    <String, dynamic>{
      'ciclo_id': instance.cicloId,
      'data_inicio': instance.dataInicio.toIso8601String(),
      'data_fim': instance.dataFim.toIso8601String(),
      'etapas': instance.etapas,
      'equipamento_id': instance.equipamentoId,
      'equipamento_carga': instance.equipamentoCarga,
      'ponto_basculamento': instance.pontoBasculamento,
      'statusSincronizacao': instance.statusSincronizacao,
    };

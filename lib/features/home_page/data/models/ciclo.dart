import 'package:fast2mine_challenge/core/utils/converters.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/coordenadas.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/etapa.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ciclo.g.dart';

@JsonSerializable()
class Ciclo {
  @JsonKey(name: 'ciclo_id')
  late String cicloId;

  @JsonKey(name: 'data_inicio')
  late DateTime dataInicio;

  @JsonKey(name: 'data_fim')
  late DateTime dataFim;

  @JsonKey(
    name: 'etapas',
    fromJson: etapasFromJsonString,
    toJson: etapasToJsonString,
  )
  late List<Etapa> etapas;

  @JsonKey(name: 'equipamento_id')
  late String equipamentoId;

  @JsonKey(name: 'equipamento_carga')
  late String equipamentoCarga;

  @JsonKey(
    name: 'ponto_basculamento',
    fromJson: coordenadasFromJsonString,
    toJson: coordenadasToJsonString,
  )
  late Coordenadas pontoBasculamento;

  @JsonKey(name: 'status_sincronizacao')
  late String statusSincronizacao;

  Ciclo(
    this.cicloId,
    this.dataInicio,
    this.dataFim,
    this.etapas,
    this.equipamentoId,
    this.equipamentoCarga,
    this.pontoBasculamento,
    this.statusSincronizacao,
  );

  factory Ciclo.fromJson(Map<String, dynamic> json) => _$CicloFromJson(json);

  Map<String, dynamic> toJson() => _$CicloToJson(this);

  static String get createTable => '''
    CREATE TABLE Ciclos (
      ciclo_id TEXT PRIMARY KEY,
      data_inicio TEXT NOT NULL,
      data_fim TEXT NOT NULL,
      etapas TEXT NOT NULL,
      equipamento_id TEXT NOT NULL,
      equipamento_carga TEXT NOT NULL,
      ponto_basculamento TEXT NOT NULL,
      status_sincronizacao TEXT NOT NULL
    )
    ''';
}

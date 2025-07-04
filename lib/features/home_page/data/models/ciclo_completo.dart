import 'package:fast2mine_challenge/features/home_page/data/models/coordenadas.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/etapa.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ciclo_completo.g.dart';

@JsonSerializable()
class CicloCompleto {
  @JsonKey(name: 'ciclo_id')
  final String cicloId;
  @JsonKey(name: 'data_inicio')
  final DateTime dataInicio;
  @JsonKey(name: 'data_fim')
  final DateTime dataFim;
  final List<Etapa> etapas;
  @JsonKey(name: 'equipamento_id')
  final String equipamentoId;
  @JsonKey(name: 'equipamento_carga')
  final String equipamentoCarga;
  @JsonKey(name: 'ponto_basculamento')
  final Coordenadas pontoBasculamento;
  @JsonKey(includeToJson: true)
  @JsonKey(name: 'status_sincronizacao')
  String get statusSincronizacao =>
      sincronizado ? 'SINCRONIZADO' : 'NÃO SINCRONIZADO';

  @JsonKey(includeToJson: false)
  final bool sincronizado;

  CicloCompleto(
    this.cicloId,
    this.dataInicio,
    this.dataFim,
    this.etapas,
    this.equipamentoId,
    this.equipamentoCarga,
    this.pontoBasculamento,
    this.sincronizado,
  );

  factory CicloCompleto.fromJson(Map<String, dynamic> json) =>
      _$CicloCompletoFromJson(json);

  Map<String, dynamic> toJson() => _$CicloCompletoToJson(this);
}

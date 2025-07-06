import 'dart:convert';

import 'package:fast2mine_challenge/features/home_page/data/models/coordenadas.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/etapa.dart';

String etapasToJsonString(List<Etapa> etapas) =>
    jsonEncode(etapas.map((e) => e.toJson()).toList());

List<Etapa> etapasFromJsonString(String source) => (jsonDecode(source) as List)
    .map((e) => Etapa.fromJson(e as Map<String, dynamic>))
    .toList();

String coordenadasToJsonString(Coordenadas coords) =>
    jsonEncode(coords.toJson());

Coordenadas coordenadasFromJsonString(String source) =>
    Coordenadas.fromJson(jsonDecode(source));

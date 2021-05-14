import 'dart:convert';

import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/data/model/presenca_resumo.dart';
import 'package:lpbp/app/res/lpbp_http.dart';
import 'package:lpbp/app/res/static.dart';
import 'package:http/http.dart' as http;

class PresencaProvider{
  final httpfat = LpbpHttp();

  Future<bool> salvar(Presenca presenca) async {
    var parse = Uri.parse('${url}presenca');
    final response = await http.post(parse,
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(presenca.toMap()));

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> atualizar(Presenca presenca) async {
    var parse = Uri.parse('${url}presenca');
    final response = await http.put(parse,
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(presenca.toMap()));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PresencaResumo>> getPresencaResumo(String de, String ate) async {
    var parse = Uri.parse('${url}presenca');
    var response = await LpbpHttp().get(parse,
        headers: <String, String>{"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      var listUsuarioModel = jsonResponse.map<PresencaResumo>((map) {
        return PresencaResumo.fromJson(map);
      }).toList();
      return listUsuarioModel;
    } else {
    }
    return null;
  }
}

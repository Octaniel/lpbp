import 'dart:convert';

import 'package:lpbp/app/data/model/presenca.dart';
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
}

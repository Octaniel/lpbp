import 'dart:convert';

import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/res/lpbp_http.dart';
import 'package:lpbp/app/res/static.dart';
import 'package:http/http.dart' as http;

class PresencaProvider{
  final httpfat = LpbpHttp();

  Future<bool> salvar(Presenca presenca) async {
    print(json.encode(presenca.toMap()));
    final response = await http.post("${url}presenca",
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(presenca.toMap()));

    if (response.statusCode == 201) {
      return true;
    } else {
      print("object");
      return false;
    }
  }

  Future<bool> atualizar(Presenca presenca) async {
    print(json.encode(presenca.toMap()));
    final response = await http.put("${url}presenca",
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(presenca.toMap()));

    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      print("object");
      return false;
    }
  }
}
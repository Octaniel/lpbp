import 'dart:convert';

import 'package:lpbp/app/data/model/pessoa.dart';
import 'package:lpbp/app/res/lpbp_http.dart';
import 'package:lpbp/app/res/static.dart';
import 'package:http/http.dart' as http;

class PessoaProvider {
  final httpfat = LpbpHttp();

  Future<List<Pessoa>> listar() async {
    final response =
    await http.get("${url}pessoa",headers: <String,String>{
      "Content-Type":"application/json"
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      var listUsuarioModel = jsonResponse.map<Pessoa>((map) {
        return Pessoa.fromMap(map);
      }).toList();
      return listUsuarioModel;
    } else {
      print(response.body);
      print("object");
    }
    return List<Pessoa>();
  }

  Future<bool> salvar(Pessoa pessoa) async {
    final response = await httpfat.post("${url}video",
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(pessoa.toMap()));
    if (response.statusCode == 201) {
      return true;
    } else {
      print("object");
      return false;
    }
  }
}

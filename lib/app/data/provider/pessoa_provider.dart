import 'dart:convert';

import 'package:lpbp/app/data/model/pessoa.dart';
import 'package:lpbp/app/res/lpbp_http.dart';
import 'package:lpbp/app/res/static.dart';
import 'package:http/http.dart' as http;

class PessoaProvider {
  final httpfat = LpbpHttp();

  Future<List<Pessoa>> listar() async {
    var parse = Uri.parse('${url}pessoa');
    final response =
    await http.get(parse,headers: <String,String>{
      "Content-Type":"application/json"
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      var listUsuarioModel = jsonResponse.map<Pessoa>((map) {
        return Pessoa.fromMap(map);
      }).toList();
      return listUsuarioModel;
    } else {
    }
    return <Pessoa>[];
  }

  Future<bool> salvar(Pessoa pessoa) async {
    var parse = Uri.parse('${url}video');
    final response = await httpfat.post(parse,
        headers: <String, String>{"Content-Type": "application/json"},
        body: json.encode(pessoa.toMap()));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lpbp/app/data/model/usuario.dart';
import 'package:lpbp/app/res/lpbp_http.dart';
import 'package:lpbp/app/res/static.dart';

final baseUrl = url;

class AuthProvider {
  final httpClient = http.Client();

  Future<bool> registar() async {
    var parse = Uri.parse('${url}usuario/registar');
    var response = await LpbpHttp().get(parse,
        headers: <String, String>{"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return true;
    } else {
    }
    return false;
  }

  Future<bool> setarTodosAsPresencasParaPresenteEntre(String de, String ate) async {
    var parse = Uri.parse('${url}usuario/setarTodosAsPresencasParaPresenteEntre?de=$de&ate=$ate');
    var response = await LpbpHttp().get(parse,
        headers: <String, String>{"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return true;
    } else {
    }
    return false;
  }

  Future<bool> accsessTokenExpirado() async {
    final storage = GetStorage();
    var read = storage.read("date_expires_in");
    var read1 = storage.read("expires_in");
    if (read == null) return true;
    var date = DateTime.parse(read);
    int i = int.parse(read1);
    date = date.add(Duration(seconds: i));
    if (date.isAfter(DateTime.now())) {
      return false;
    }
    return true;
  }

  Future<void> refreshToken() async {
    final storage = GetStorage();
    var read1 = storage.read("refresh_token");
    var parse = Uri.parse('${baseUrl}oauth/token');
    var response =
        await http.post(parse, headers: <String, String>{
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Basic YW5ndWxhcjpAbmd1bEByMA==",
    }, body: <String, String>{
      "grant_type": "refresh_token",
      "refresh_token": read1 == null ? "" : read1
    });
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body);
      storage.write("access_token", decode["access_token"]);
      storage.write("date_expires_in", DateTime.now().toString());
      storage.write("expires_in", decode["expires_in"].toString());
    }
  }

  Future<bool> verificarERenovarToken() async {
    if (await accsessTokenExpirado()) {
      await refreshToken();
      if (await accsessTokenExpirado()) {
        return false;
      }
    }
    return true;
  }
}

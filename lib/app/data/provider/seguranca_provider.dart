import 'dart:convert';


import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lpbp/app/data/model/usuario.dart';
import 'package:lpbp/app/res/lpbp_http.dart';
import 'package:lpbp/app/res/static.dart';


final baseUrl = url;

class SegurancaProvider {
  final httpClient = http.Client();

  Future<List<Usuario>> getAll() async {
    try {
      var parse = Uri.parse(baseUrl + 'home');
      var response = await httpClient.get(parse);
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        var listUsuario = jsonResponse.map<Usuario>((map) {
          return Usuario.fromJson(map);
        }).toList();
        return listUsuario;
      } else {
      }
    } catch (_) {}
    return [];
  }

  Future<Usuario> getId(int id) async {
    var parse = Uri.parse('${url}usuario/$id');
    var response = await LpbpHttp().get(parse,
        headers: <String, String>{"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return Usuario.fromJson(jsonResponse);
    } else {
    }
    return null;
  }



  Future<bool> login(String senha, String email) async {
    String login = "username=$email&password=$senha&grant_type=password";
    var parse = Uri.parse('${baseUrl}oauth/token');
    final response = await http.post(parse,
        headers: <String, String>{
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Basic YW5ndWxhcjpAbmd1bEByMA==",
          "bmobile": "b",
        },
        body: login);
    if (response.statusCode == 200) {
      final storage = GetStorage();
      var decode = jsonDecode(response.body);
      await storage.write("nomeUsuario", decode["nome"]);
      await storage.write("idUsuario", decode["idUsuario"]);
      await storage.write("access_token", decode["access_token"]);
      await storage.write("date_expires_in", DateTime.now().toString());
      await storage.write("expires_in", decode["expires_in"].toString());
      await storage.write("refresh_token", decode["refresh_token"]);
      return true;
    }
    return false;
  }

  Future<bool> add(Usuario obj) async {
    var parse = Uri.parse('${baseUrl}usuario/add');
    var response = await LpbpHttp().post(parse,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(obj));
    if (response.statusCode == 201) {
      return true;
    } else {
    }
    return false;
  }

  Future<bool> logout() async {
    final httpfat = LpbpHttp();
    final storage = GetStorage();
    var parse = Uri.parse('${baseUrl}tokens/revoke');
    var response = await httpfat.delete(parse);
    if (response.statusCode == 204) {
      await storage.erase();
      return true;
    }
//    await storage.clear();
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
    var read1 = storage.read<String>("refresh_token");
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

  Future<List<Usuario>> listar() async {
    var parse = Uri.parse('${url}usuario/listar');
    final response =
    await http.get(parse,headers: <String,String>{
      "Content-Type":"application/json"
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      var listUsuarioModel = jsonResponse.map<Usuario>((map) {
        return Usuario.fromJson(map);
      }).toList();
      return listUsuarioModel;
    } else {
    }
    return <Usuario>[];
  }
}


import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:lpbp/app/data/repository/auth_repository.dart';

class LpbpHttp{

  final seguranca = AuthRepository();


Future<Response> get(url, {Map<String, String> headers}) =>
    _withClient((h) => http.get(url, headers: h),headers);

    Future<Response> post(url,
        {Map<String, String> headers, body, Encoding encoding}) =>
    _withClient((h) =>
        http.post(url, headers: h, body: body, encoding: encoding),headers);

        Future<Response> put(url,
        {Map<String, String> headers, body, Encoding encoding}) =>
    _withClient((h) =>
        http.put(url, headers: h, body: body, encoding: encoding),headers);

        Future<Response> delete(url, {Map<String, String> headers}) =>
    _withClient((h) => http.delete(url, headers: h),headers);


  Future<T> _withClient<T>(Future<T> Function(Map<String, String> headers) fn,Map<String, String> headers) async {
    final storage = GetStorage();
    var accsessTokenExpirado = await seguranca.accsessTokenExpirado();
    if(accsessTokenExpirado){
      await seguranca.refreshToken();
       accsessTokenExpirado = await seguranca.accsessTokenExpirado();
     if(accsessTokenExpirado){
       return null;
    }
    }
    var read = storage.read("access_token");
    if(headers==null){
      headers = Map();
    }
    headers.addAll(<String,String>{
      "Authorization":"Bearer "+read,
    });
    return fn(headers);
  }

}

import 'package:lpbp/app/data/model/usuario.dart';

import '../provider/seguranca_provider.dart';

class SegurancaRepository {
  final segurancaProvider = SegurancaProvider();


  Future<List<Usuario>> getAll() async {
    return await segurancaProvider.getAll();
  }

  Future<bool> login(String senha, String email) async {
    return await segurancaProvider.login(senha,email);
  }

  Future<bool> accsessTokenExpirado() async {
    return segurancaProvider.accsessTokenExpirado();
  }

  Future<void> refreshToken() async {
    return segurancaProvider.refreshToken();
  }

  Future<bool> logout() async{
    return await segurancaProvider.logout();
  }

  Future<bool> add(obj) async {
    return await segurancaProvider.add(obj);
  }

  Future<Usuario> getId(int id) async {
    return segurancaProvider.getId(id);
  }

  Future<bool> edit(obj) async {
    return await segurancaProvider.edit(obj);
  }

  Future<bool> delete(id) async {
    return await segurancaProvider.delete(id);
  }
}
    
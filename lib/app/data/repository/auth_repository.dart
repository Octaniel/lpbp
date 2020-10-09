import 'package:lpbp/app/data/model/usuario.dart';

import '../provider/auth_provider.dart';

class AuthRepository {
  final authProvider = AuthProvider();

  Future<List<Usuario>> getAll() async {
    return await authProvider.getAll();
  }

  Future<bool> login(String senha, String email) async {
    return await authProvider.login(senha, email);
  }

  Future<bool> accsessTokenExpirado() async {
    return authProvider.accsessTokenExpirado();
  }

  Future<void> refreshToken() async {
    return authProvider.refreshToken();
  }

  Future<bool> logout() async {
    return await authProvider.logout();
  }

  Future<bool> add(obj) async {
    return await authProvider.add(obj);
  }

  Future<Usuario> getId(int id) async {
    return authProvider.getId(id);
  }

  Future<bool> edit(obj) async {
    return await authProvider.edit(obj);
  }

  Future<bool> delete(id) async {
    return await authProvider.delete(id);
  }
}

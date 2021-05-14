import 'package:lpbp/app/data/model/usuario.dart';

import '../provider/auth_provider.dart';

class AuthRepository {
  final authProvider = AuthProvider();

  Future<bool> registar() async {
    return await authProvider.registar();
  }

  Future<bool> setarTodosAsPresencasParaPresenteEntre(String de, String ate) async {
    return await authProvider.setarTodosAsPresencasParaPresenteEntre(de, ate);
  }

  Future<bool> accsessTokenExpirado() async {
    return authProvider.accsessTokenExpirado();
  }

  Future<void> refreshToken() async {
    return authProvider.refreshToken();
  }
}

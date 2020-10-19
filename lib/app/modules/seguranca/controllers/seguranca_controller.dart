import 'package:get/get.dart';
import 'package:lpbp/app/data/model/pessoa.dart';
import 'package:lpbp/app/data/model/usuario.dart';
import 'package:lpbp/app/data/repository/seguranca_repository.dart';

class SegurancaController extends GetxController{
  final repository = SegurancaRepository();

  var pessoa = Pessoa();
  var usuario = Usuario();

  var _senha = ''.obs;
  var _email = ''.obs;

  get senha => _senha.value;

  set senha(value) {
    _senha.value = value;
  }

  var _circularProgressButaoRegistrar = false.obs;

  get circularProgressButaoRegistrar => _circularProgressButaoRegistrar.value;

  set circularProgressButaoRegistrar(value) {
    _circularProgressButaoRegistrar.value = value;
    update();
  }

  Future<bool> logar() async {
   return await repository.login(senha, email);
  }

  get email => _email.value;

  set email(value) {
    _email.value = value;
  }

  salvarCliente(){

  }

  Future<bool> salvarUsuario() async {
    usuario.pessoa = pessoa;
    usuario.nome = pessoa.nome.toLowerCase().trim();
   return await repository.add(usuario);
  }



}

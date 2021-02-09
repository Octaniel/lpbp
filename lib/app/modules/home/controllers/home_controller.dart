import 'package:get/get.dart';
import 'package:lpbp/app/app_controller.dart';
import 'package:lpbp/app/data/model/pessoa.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/data/model/usuario.dart';
import 'package:lpbp/app/data/repository/seguranca_repository.dart';

class HomeController extends GetxController {
  final repository = SegurancaRepository();
  final _empregados = <Usuario>[].obs;
  final _audio = ''.obs;
  final _presenca = Presenca().obs;
  final _boxShadow = true.obs;
  final _isPlay = false.obs;
  final _circularProgressButaoRegistrar = false.obs;
  var pessoa = Pessoa();
  var usuario = Usuario();

  get circularProgressButaoRegistrar => _circularProgressButaoRegistrar.value;

  set circularProgressButaoRegistrar(value) {
    _circularProgressButaoRegistrar.value = value;
  }

  bool get isPlay => _isPlay.value;

  set isPlay(bool value) {
    _isPlay.value = value;
    update(['isPlay']);
  }

  bool get boxShadow => _boxShadow.value;

  set boxShadow(bool value) {
    _boxShadow.value = value;
    update(['boxShadow']);
  }

  Presenca get presenca => _presenca.value;

  set presenca(Presenca value) {
    _presenca.value = value;
  }

  String get audio => _audio.value;

  set audio(String value) {
    _audio.value = value;
    update(['playReplay']);
  }

  HomeController(){
    listarEmpregados();
  }

  // ignore: invalid_use_of_protected_member
  List<Usuario> get empregados => _empregados.value;

  set empregados(List<Usuario> value) {
    _empregados.assignAll(value);
  }

  listarEmpregados() async {
    empregados = Get.find<AppController>().empregados;
    update();
  }

  Future<bool> salvarUsuario() async {
    usuario.pessoa = pessoa;
    usuario.nome = pessoa.nome.toLowerCase().trim();
    return await repository.add(usuario);
  }


}

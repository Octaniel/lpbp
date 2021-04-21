import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/data/repository/presenca_repository.dart';
import 'package:lpbp/app/routes/app_routes.dart';

import 'data/model/usuario.dart';
import 'data/provider/seguranca_provider.dart';
import 'data/repository/pessoa_repository.dart';
import 'data/repository/seguranca_repository.dart';

class AppController extends GetxController {
  final repository = SegurancaRepository();
  final presencaRepository = PresencaRepository();
  final assetsAudioPlayer = AssetsAudioPlayer();
  final _empregados = <Usuario>[].obs;
  final pessoaRepository = PessoaRepository();
  final listPresenca = <Presenca>[];
  var _usuario = Usuario().obs;
  final _logado = false.obs;

  bool get logado => _logado.value;

  set logado(bool value) {
    _logado.value = value;
    update(['mostrarLogin']);
  }

  AppController() {
    assetsAudioPlayer.open(
      Audio("assets/audio/1.mp3"),
      autoStart: false,
    );
    verificarLogado();
    listarEmpregados();
  }

  Usuario get usuario => _usuario.value;

  set usuario(Usuario value) {
    _usuario.value = value;
  }

  // ignore: invalid_use_of_protected_member
  List<Usuario> get empregados => _empregados.value;

  set empregados(List<Usuario> value) {
    _empregados.assignAll(value);
  }

  tocarOuPausar() async {
    await assetsAudioPlayer.playOrPause();
  }

  parar() {
    assetsAudioPlayer.stop();
  }

  salvarPresencas(){
    print(listPresenca.length);
    listPresenca.forEach((element) {
      presencaRepository.salvar(element);
    });
  }

  Future<void> salvarPresenca(Presenca presenca) async {
    await presencaRepository.salvar(presenca);
  }

  Future<void> atualizarPresenca(Presenca presenca) async {
    await presencaRepository.atualizar(presenca);
  }

  salvarTodos(){
    listPresenca.forEach((element) {
      presencaRepository.salvar(element);
    });
  }

 Future<void> listarEmpregados() async {
    empregados = await repository.listar();
    update();
  }

  Usuario filtrarPorCodigo(String codigo){
    return empregados.firstWhere((element) => element.pessoa.codigo == codigo, orElse: (){return null;});
  }

  Future<void> refreshUsuario() async {
    print('ggggg');
    final storage = GetStorage();
    var id = storage.read('idUsuario');
    usuario = await repository.getId(id);
    logado = true;
    print(usuario.tipo);
    print('ggggg');
    update();
  }

  Future<bool> logout() async {
    usuario = Usuario();
    return await repository.logout();
  }

  Future<bool> verificarLogado() async {
    print('<<<<<<<<111');
    if (await SegurancaProvider().verificarERenovarToken()) {
      await refreshUsuario();
      logado = true;
      print(logado);
    }
  }

  @override
  void onClose() {
    print("object");
    super.onClose();
  }
}

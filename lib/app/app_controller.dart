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
    listarEmpregados();
    if(!GetPlatform.isWeb){
      entrada();
      saida();
      momentoDeTocar();
    }
    verificarLogado();
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

  salvarPresenca(Presenca presenca){
    presenca.justificada = true;
    presencaRepository.atualizar(presenca);
  }

  saida() async {
    while (true) {
      await Future.delayed(Duration(minutes: 1), () async {
        var dateTime = DateTime.now();
        var dateTime2 = DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day,
            13,
            30,
            dateTime.second,
            dateTime.millisecond,
            dateTime.microsecond);
        var dateTime3 = DateTime(dateTime.year, dateTime.month, dateTime.day,
            19, 00, dateTime.second, dateTime.millisecond, dateTime.microsecond);
        if (dateTime.isAtSameMomentAs(dateTime2) ||
            dateTime.isAtSameMomentAs(dateTime3)) {
          Get.offNamed(Routes.MARCAPONTO);
          tocarOuPausar();
          await Future.delayed(Duration(minutes: 2), () async {
            tocarOuPausar();
            await Future.delayed(Duration(minutes: 3), () {
              Get.offNamed(Routes.HOME);
              listPresenca.forEach((element) {
                presencaRepository.salvar(element);
              });
            });
          });
        }
      });
    }
  }

  entrada() async {
    while (true) {
      await Future.delayed(Duration(minutes: 1), () async {
        // tocarOuPausar();
        var dateTime = DateTime.now();
        var dateTime2 = DateTime(dateTime.year, dateTime.month, dateTime.day, 7,
            0, dateTime.second, dateTime.millisecond, dateTime.microsecond);
        var dateTime3 = DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day,
            9,
            40,
            dateTime.second,
            dateTime.millisecond,
            dateTime.microsecond);
        if (dateTime.isAtSameMomentAs(dateTime2) ||
            dateTime.isAtSameMomentAs(dateTime3)) {
          Get.offNamed(Routes.MARCAPONTO);
          tocarOuPausar();
          await Future.delayed(Duration(minutes: 2), () async {
            tocarOuPausar();
            await Future.delayed(Duration(minutes: 3), () {
              Get.offNamed(Routes.HOME);
              listPresenca.forEach((element) {
                presencaRepository.salvar(element);
              });
            });
          });
        }
      });
    }
  }

  momentoDeTocar() async {
    while (true) {
      await Future.delayed(Duration(minutes: 60), () async {
        var dateTime = DateTime.now();
        var add = DateTime(dateTime.year, dateTime.month, dateTime.day, 19, 1,
            dateTime.second, dateTime.millisecond, dateTime.microsecond);
        var subtract = DateTime(dateTime.year, dateTime.month, dateTime.day, 6,
            59, dateTime.second, dateTime.millisecond, dateTime.microsecond);
        if (dateTime.isBefore(add) && dateTime.isAfter(subtract)) {
          var random = Random();
          var nextInt = random.nextInt(61);
          await Future.delayed(Duration(minutes: nextInt), () async {
            Get.offNamed(Routes.MARCAPONTO);
            tocarOuPausar();
            await Future.delayed(Duration(minutes: 2), () async {
              tocarOuPausar();
              await Future.delayed(Duration(minutes: 3), () {
                Get.offNamed(Routes.HOME);
                listPresenca.forEach((element) {
                  presencaRepository.salvar(element);
                });
              });
            });
          });
        }
      });
    }
  }

 Future<void> listarEmpregados() async {
    empregados = await repository.listar();
    update();
  }

  Usuario filtrarPorCodigo(String codigo){
    return empregados.firstWhere((element) => element.pessoa.codigo == codigo, orElse: (){return null;});
  }

  Future<void> refreshUsuario() async {
    final storage = GetStorage();
    var id = storage.read('idUsuario');
    usuario = await repository.getId(id);
    logado = true;
    update();
  }

  Future<bool> logout() async {
    usuario = Usuario();
    return await repository.logout();
  }

  Future<bool> verificarLogado() async {
    if (await SegurancaProvider().verificarERenovarToken()) {
      await Get.find<AppController>().refreshUsuario();
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

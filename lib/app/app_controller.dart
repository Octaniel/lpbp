import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/data/repository/presenca_repository.dart';
import 'package:lpbp/app/res/static.dart';
import 'package:lpbp/app/routes/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final presencas = <Presenca>[];
  final presencasTodos = <Presenca>[];
  final ausencias = <Presenca>[];
  var _usuario = Usuario().obs;
  final _logado = false.obs;
  bool connectionStatus;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool get logado => _logado.value;

  set logado(bool value) {
    _logado.value = value;
    update(['mostrarLogin']);
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

  salvarPresencas() {
    print(listPresenca.length);
    listPresenca.forEach((element) {
      presencaRepository.salvar(element);
    });
  }

  Future<int> salvarTodasPresencas() async {
    try {
      presencasTodos.forEach((presenca) async {
        if (presenca.presente) {
          var split = presenca.nomeFoto.split('\\.');
          var split2 = split[split.length - 1].split('\\.')[0];
          var saveArquiv =
              await saveArquivo("imagens/$split2", presenca.nomeFoto);
          presenca.nomeFoto = saveArquiv;
        }
        var bool = await presencaRepository.salvarOffline(presenca);
        if (!bool) {
          return 0;
        }
      });
      presencasTodos.clear();
      var getStorage = GetStorage();
      getStorage.write("presencasTodos", []);
      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<void> salvarPresenca(Presenca presenca) async {
    // if (_connectionStatus)
    //   await presencaRepository.salvar(presenca);
    // else {
    presenca.presente = true;
    presencas.add(presenca);
    // }
  }

  Future<void> salvarAusencias() async {
    var dateTime = DateTime.now();
    if (dateTime.hour > 13 || (dateTime.hour == 13 && dateTime.minute >= 30)) {
      var pre = filtrarPorTurno("TARDE");
      pre.forEach((elemen) {
        bool v = true;
        presencas.forEach((element) {
          if (elemen.pessoa.codigo == element.codigo) {
            v = false;
            return;
          }
        });
        if (v) {
          Presenca pres = Presenca();
          pres.codigo = elemen.pessoa.codigo;
          pres.presente = false;
          ausencias.add(pres);
        }
      });
    } else {
      var pre = filtrarPorTurno("MANHA");
      pre.forEach((elemen) {
        bool v = true;
        presencas.forEach((element) {
          if (elemen.pessoa.codigo == element.codigo) {
            v = false;
            return;
          }
        });
        if (v) {
          Presenca pres = Presenca();
          // pres.dataCriacao = DateTime.now().toUtc();
          pres.codigo = elemen.pessoa.codigo;
          pres.presente = false;
          ausencias.add(pres);
        }
      });
    }
    presencasTodos.addAll(presencas);
    presencasTodos.addAll(ausencias);
    var getStorage = GetStorage();
    getStorage.write("presencasTodos", presencasTodos);
    ausencias.clear();
    presencas.clear();
  }

  Future<void> atualizarPresenca(Presenca presenca) async {
    await presencaRepository.atualizar(presenca);
  }

  salvarTodos() {
    listPresenca.forEach((element) {
      presencaRepository.salvar(element);
    });
  }

  Future<int> listarEmpregados(bool connectionStatus) async {
    try {
      final storage = GetStorage();
      if (connectionStatus) {
        empregados = await repository.listar();
        storage.write("empregados", empregados);
      } else {
        var read1 = storage.read("empregados");
        if (read1 != null)
          empregados = storage.read("empregados").map<Usuario>((map) {
            return Usuario.fromJson(map);
          }).toList();
        List read = storage.read("presencasTodos");
        print('${read.length}TTTTTTT');
        if (read != null)
          presencasTodos.addAll(read.map<Presenca>((map) {
            return Presenca.fromJson1(map);
          }).toList());
        empregados.forEach((element) {
          print(
              '${empregados[1].pessoa.codigo}->${empregados[1].pessoa.turno}');
        });
      }
      print('${empregados.length}llllllllllllllll');
      update();
      return 1;
    } catch (e) {
      return 0;
    }
  }

  Usuario filtrarPorCodigo(String codigo) {
    return empregados.firstWhere((element) => element.pessoa.codigo == codigo,
        orElse: () {
      return null;
    });
  }

  List<Usuario> filtrarPorTurno(String turno) {
    return empregados
        .where((element) => element.pessoa.turno == turno)
        .toList();
  }

  momentoDeTocar() async {
    while (true) {
      print('11111');
      await Future.delayed(Duration(minutes: 60), () async {
        print('22222');
        var dateTime = DateTime.now();
        var add = DateTime(dateTime.year, dateTime.month, dateTime.day, 19, 1,
            dateTime.second, dateTime.millisecond, dateTime.microsecond);
        var subtract = DateTime(dateTime.year, dateTime.month, dateTime.day, 8,
            0, dateTime.second, dateTime.millisecond, dateTime.microsecond);
        if (dateTime.isBefore(add) && dateTime.isAfter(subtract)) {
          print('33333');
          var random = Random();
          var nextInt = random.nextInt(61);
          print(nextInt);
          await Future.delayed(Duration(minutes: nextInt), () async {
            print('44444');
            Get.offNamed(Routes.MARCAPONTO);
            tocarOuPausar();
            await Future.delayed(Duration(minutes: 2), () async {
              tocarOuPausar();
              await Future.delayed(Duration(minutes: 8), () {
                Get.offNamed(Routes.HOME);
                salvarAusencias();
              });
            });
          });
        }
      });
    }

    while (true) {
      await Future.delayed(Duration(seconds: 3), () async {
        await Future.delayed(Duration(seconds: 2), () async {
          Get.offNamed(Routes.MARCAPONTO);
          // tocarOuPausar();
          await Future.delayed(Duration(minutes: 1), () async {
            // tocarOuPausar();
            await Future.delayed(Duration(minutes: 1), () {
              Get.offNamed(Routes.HOME);
              salvarAusencias();
            });
          });
        });
      });
    }
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

  // Future<void> updateConnectionStatus() async {
  //   String login = "username=rrrr&password=tttt&grant_type=password";
  //   var parse = Uri.parse('${baseUrl}oauth/token');
  //   try {
  //     final response = await http.post(parse,
  //         headers: <String, String>{
  //           "Content-Type": "application/x-www-form-urlencoded",
  //           "Authorization": "Basic YW5ndWxhcjpAbmd1bEByMA==",
  //           "bmobile": "b",
  //         },
  //         body: login);
  //
  //     if (response.statusCode == 200 || response.statusCode == 400) {
  //       connectionStatus = true;
  //     } else {
  //       connectionStatus = false;
  //       Future.delayed(Duration(seconds: 5), () {
  //         Navigator.pop(Get.context);
  //         Navigator.pop(Get.context);
  //       });
  //     }
  //   } catch (e) {
  //     connectionStatus = false;
  //     Future.delayed(Duration(seconds: 5), () {
  //       Navigator.pop(Get.context);
  //       Navigator.pop(Get.context);
  //     });
  //   }
  //
  //   listarEmpregados();
  //   if (connectionStatus) {
  //     verificarLogado();
  //   }
  // }

  @override
  void onInit() {
    assetsAudioPlayer.open(
      Audio("assets/audio/1.mp3"),
      autoStart: false,
    );
    momentoDeTocar();
    listarEmpregados(false);
    super.onInit();
  }

  Future<String> savePhoto(String path, String name) async {
    Directory directory;
    String path1 = '';
    if (await _requestPermission(Permission.storage)) {
      directory = await getExternalStorageDirectory();
      String newPath = "";
      print(directory);
      List<String> paths = directory.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        } else {
          break;
        }
      }
      newPath = newPath + "/lpbp";
      directory = Directory(newPath);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      } else {
        File saveFile = File(directory.path + "/$name.jpg");
        File create = await saveFile.create();
        File file = File(path);
        File copySync = file.copySync(create.absolute.path);
        print('${copySync.path}');
        path1 = copySync.path;
      }
    }
    return path1;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}

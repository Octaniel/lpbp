import 'dart:async';
import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:lpbp/app/res/static.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../app_controller.dart';

// ignore: must_be_immutable
class RecordPage extends GetView<HomeController> {
  TextEditingController controler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.boxShadow = true;
        controller.isPlay = false;
        controller.presencaa = Presenca();
        controller.pauseGrav = false;
        controller.gravando = false;
        AudioManager.instance.stop();
        print('saiu');
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Justificar"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height: Get.height * .20,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 4, 125, 141),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
              ),
              ListView(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 175,
                        ),
                        GetBuilder<HomeController>(
                          builder: (_) {
                            return controller.gravando
                                ? Text(
                                    "Gravando...",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text("");
                          },
                          id: 'gravando',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            startRecord();
                          },
                          child: GetBuilder<HomeController>(
                            builder: (_) {
                              return AnimatedContainer(
                                height: 80,
                                width: 80,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    boxShadow: controller.boxShadow
                                        ? [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 4, 125, 141),
                                                blurRadius: 30,
                                                spreadRadius: 20),
                                          ]
                                        : [],
                                    color: Color.fromARGB(255, 4, 125, 141),
                                    borderRadius: BorderRadius.circular(110)),
                                duration: Duration(
                                    seconds: controller.gravando ? 15 : 0),
                                child: Icon(
                                  Icons.record_voice_over_outlined,
                                  size: 40,
                                ),
                              );
                            },
                            id: 'boxShadow',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GetBuilder<HomeController>(
                          builder: (_) {
                            return Visibility(
                              visible: controller.pauseGrav,
                              replacement: ''.text.make(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      !controller.isPlay
                                          ? Icons.play_arrow
                                          : Icons.pause,
                                      color: Color.fromARGB(255, 4, 125, 141),
                                    ),
                                    onPressed: () {
                                      play();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.replay,
                                        color:
                                            Color.fromARGB(255, 4, 125, 141)),
                                    onPressed: () {
                                      controller.pauseGrav = false;
                                      print('ddddddd');
                                      controller.audio = '';
                                      controller.boxShadow = true;
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                          id: 'playReplay',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 300,
                          decoration: ShapeDecoration(
                            color: Color(0xFFEFF0F2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: controler,
                            obscureText: true,
                            obscuringCharacter: '#',
                            // validator: (v) {
                            //   return v == null || v.isEmpty
                            //       ? 'Preencha a sua Senha'
                            //       : v.length < 6
                            //       ? 'Todas senhas é maior que 6'
                            //       : null;
                            // },
                            onChanged: (v) {
                              controller.presencaa.codigo = v;
                            },

                            decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(15)),
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(15)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                prefixIcon: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: ShapeDecoration(
                                    color: Color.fromARGB(255, 4, 125, 141),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(9)),
                                  ),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                ),
                                hintText: 'Sua Senha'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 45,
                    margin: EdgeInsets.symmetric(horizontal: 100),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                      color: Color.fromARGB(255, 4, 125, 141),
                      onPressed: () async {
                        validarForm();
                      },
                      child: 'Justificar'.text.white.make(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    // bool hasPermission = true;
    if (hasPermission) {
      controller.audio = await getFilePath();
      RecordMp3.instance.start(controller.audio, (type) {});
      controller.gravando = true;
      controller.boxShadow = false;
      await Future.delayed(Duration(seconds: 15), () {
        RecordMp3.instance.stop();
        controller.gravando = false;
        controller.pauseGrav = true;
        controller.listarEmpregados();
      });
    } else {
      Get.rawSnackbar(
          icon: Icon(
            FontAwesomeIcons.erlang,
            color: Colors.white,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFFFE3C3C),
          messageText: Text(
            'Deves aceitar permisão antes de gravares a justificação',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          borderRadius: 10,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    print(sdPath);
    return sdPath + "/test_${i++}.mp3";
  }

  Future<void> play() async {
    if (controller.audio != null && File(controller.audio).existsSync()) {
      if (!controller.isPlay) {
        AudioManager.instance.start(controller.audio, "title", desc: 'desc', cover: '');
        controller.isPlay = true;
        await Future.delayed(Duration(seconds: 15), () {
          controller.isPlay = false;
        });
      }
    }
  }

  validarForm() async {
    // presenca==null?presenca = Get.arguments:print(presenca);
    if (controller.audio.isNotEmpty && controller.presencaa.codigo.isNotEmpty) {
      if (controller.presencaa.codigo != controller.pessoa.codigo) {
        Get.rawSnackbar(
            icon: Icon(
              FontAwesomeIcons.erlang,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFFFE3C3C),
            messageText: Text(
              'Este codigo não é seu',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
      } else {
        var find = Get.find<AppController>();
        var filtrarPorCodigo =
            find.filtrarPorCodigo(controller.presencaa.codigo);
        var nomeCompleto =
            '${filtrarPorCodigo.nome} ${filtrarPorCodigo.pessoa.apelido}';
        var dateTime = DateTime.now();
        var nomeAudio =
            '${nomeCompleto}_${dateTime.year}-${dateTime.month}-${dateTime.day}_${dateTime.hour}:${dateTime.minute}';
        var s = await saveArquivo("audios/$nomeAudio", controller.audio);
        controller.presencaa.nomeAudio = s;
        controller.presencaa.justificada = true;
        await find.atualizarPresenca(controller.presencaa);
        controller.pessoa.presencas.forEach((element) {
          if (element.id == controller.presencaa.id)
            element = controller.presencaa;
          controller.listarEmpregados();
        });
        Get.rawSnackbar(
            icon: Icon(FontAwesomeIcons.check),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF3CFEB5),
            messageText: Text(
              'Justificação salva com sucesso',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
        controller.audio = '';
        controller.presencaa.codigo = '';
        controller.boxShadow = true;
        controller.pauseGrav = false;
        controler.text = '';
        // Future.delayed(Duration(seconds: 2), () {
        //   Get.offAllNamed(Routes.HOME);
        // });
      }
    } else {
      Get.rawSnackbar(
          icon: Icon(
            FontAwesomeIcons.erlang,
            color: Colors.white,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFFFE3C3C),
          messageText: Text(
            'Deves gravar a justificão e preencher o campo com a seu codigo',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          borderRadius: 10,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
      Future.delayed(Duration(seconds: 2), () {});
    }
  }
}

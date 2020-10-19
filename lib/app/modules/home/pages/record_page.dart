import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:lpbp/app/res/static.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../app_controller.dart';

// ignore: must_be_immutable
class RecordPage extends GetView<HomeController> {
  Presenca presenca;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      GestureDetector(
                        onTap: () {
                          startRecord();
                          controller.boxShadow = false;
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
                                              blurRadius: 20,
                                              spreadRadius: 8),
                                        ]
                                      : [],
                                  color: Color.fromARGB(255, 4, 125, 141),
                                  borderRadius: BorderRadius.circular(110)),
                              duration: Duration(seconds: 2),
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
                      GetBuilder<HomeController>(builder: (_) {
                        return Visibility(
                          visible: controller.audio.isNotBlank,
                          replacement: ''.text.make(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.play_arrow, color: Color.fromARGB(255, 4, 125, 141),),
                                onPressed: () {
                                  play();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.replay, color: Color.fromARGB(255, 4, 125, 141)),
                                onPressed: () {
                                  controller.audio = '';
                                  controller.boxShadow = true;
                                },
                              )
                            ],
                          ),
                        );
                      }, id: 'playReplay',),
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
                            controller.presenca.codigo = v;
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
                      controller.boxShadow = true;
                    },
                    child: 'Justificar'.text.white.make(),
                  ),
                ),
              ],
            )
          ],
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
      await Future.delayed(Duration(seconds: 15), () {
        RecordMp3.instance.stop();
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

  void play() {
    if (controller.audio != null && File(controller.audio).existsSync()) {
      AudioPlayer audioPlayer = AudioPlayer();
      audioPlayer.play(controller.audio, isLocal: true);
    }
  }

  validarForm() async {
     presenca==null?presenca = Get.arguments:print(presenca);
    if (controller.audio.isNotEmpty && controller.presenca.codigo.isNotEmpty) {
      var find = Get.find<AppController>();
      var filtrarPorCodigo = find.filtrarPorCodigo(controller.presenca.codigo);
      var nomeCompleto = '${filtrarPorCodigo.nome} ${filtrarPorCodigo.apelido}';
      var dateTime = DateTime.now();
      var nomeAudio =
          '${nomeCompleto}_${dateTime.year}-${dateTime.month}-${dateTime.day}_${dateTime.hour}:${dateTime.minute}';
      var s = await saveArquivo("audios/$nomeAudio", controller.audio);
      presenca.nomeAudio = s;
      find.salvarPresenca(presenca);
      Get.rawSnackbar(
          icon: Icon(FontAwesomeIcons.check),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF3CFEB5),
          messageText: Text(
            'Justificação salva com sucesso',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          borderRadius: 10,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
      controller.audio = '';
      controller.presenca.codigo = '';
      // Future.delayed(Duration(seconds: 2), () {
      //   Get.offAllNamed(Routes.HOME);
      // });
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

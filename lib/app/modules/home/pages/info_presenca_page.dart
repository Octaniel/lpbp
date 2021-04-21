import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../app_controller.dart';

// ignore: must_be_immutable
class InfoPresencaPage extends GetView<HomeController> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    // Presenca controller.presencaa = Get.arguments;
    var dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    return WillPopScope(
      onWillPop: () {
        controller.isPlay = false;
        controller.presencaa = Presenca();
        return Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title:
              'Informação da ${controller.presencaa.presente ? 'presença' : 'ausencia'}'
                  .text
                  .make(),
          centerTitle: true,
        ),
        body: Center(
          child: GetBuilder<HomeController>(
            builder: (_) {
              return ListView(
                children: [
                  GetBuilder<HomeController>(
                    builder: (_) {
                      return controller.presencaa.presente == true
                          ? Container(
                              width: 200,
                              height: 300,
                              child: controller.presencaa.nomeFoto != null
                                  ? Image.network(
                                      controller.presencaa.nomeFoto,
                                      fit: BoxFit.contain,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes
                                                : null,
                                          ),
                                        );
                                      },
                                    )
                                  : Container(),
                            )
                          : Column(
                              children: [
                                controller.presencaa.nomeAudio != null
                                    ? Column(
                                        children: [
                                          'Justificação por audio:'.text.make(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: IconButton(
                                              onPressed: () {
                                                if (controller.isPlay) {
                                                  audioPlayer.pause();
                                                  controller.isPlay = false;
                                                } else {
                                                  audioPlayer.play(
                                                      controller
                                                          .presencaa.nomeAudio,
                                                      isLocal: false);
                                                  controller.isPlay = true;
                                                }
                                              },
                                              icon: Icon(controller.isPlay
                                                  ? Icons.pause
                                                  : Icons.play_arrow),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            );
                    },
                    id: 'isPlay',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      'Data da  ${controller.presencaa.presente ? 'presença' : 'ausencia'}:'
                          .text
                          .size(18)
                          .color(controller.presencaa.presente
                              ? Colors.greenAccent
                              : controller.presencaa
                                          .justificacaoAceitoPorAdministrador ==
                                      true
                                  ? Colors.lightGreenAccent
                                  : controller.presencaa
                                              .justificacaoAceitoPorGerente ==
                                          true
                                      ? Colors.lightBlueAccent
                                      : controller.presencaa.justificada
                                          ? Colors.deepOrangeAccent
                                          : Colors.redAccent)
                          .make(),
                      '${dateFormat.format(controller.presencaa.dataCriacao)}'
                          .text
                          .size(20)
                          .color(controller.presencaa.presente
                              ? Colors.greenAccent
                              : controller.presencaa
                                          .justificacaoAceitoPorAdministrador ==
                                      true
                                  ? Colors.lightGreenAccent
                                  : controller.presencaa
                                              .justificacaoAceitoPorGerente ==
                                          true
                                      ? Colors.lightBlueAccent
                                      : controller.presencaa.justificada
                                          ? Colors.deepOrangeAccent
                                          : Colors.redAccent)
                          .make(),
                    ],
                  ),
                  if (controller.presencaa.presente)
                    '*Esteve presente'.text.size(14).center.make()
                  else if (!controller.presencaa.justificada)
                    '*Ainda não foi justificada'.text.size(14).center.make()
                  else if (controller.presencaa.justificacaoAceitoPorGerente ==
                          null &&
                      controller.presencaa.justificacaoAceitoPorAdministrador ==
                          null)
                    '*Já justificada mais ainda não foi aceita por gerente'
                        .text
                        .size(14)
                        .center
                        .make()
                  else if (controller.presencaa.justificacaoAceitoPorGerente ==
                      false)
                    '*Já justificada e já foi rejeitada por gerente'
                        .text
                        .size(14)
                        .center
                        .make()
                  else if (controller.presencaa.justificacaoAceitoPorGerente ==
                          true &&
                      controller.presencaa.justificacaoAceitoPorAdministrador ==
                          null)
                    '*Já justificada e já foi aceita por gerente, mais ainda não'
                            ' foi aceita por administrador'
                        .text
                        .size(14)
                        .center
                        .make()
                  else if (controller.presencaa.justificacaoAceitoPorGerente ==
                          true &&
                      controller.presencaa.justificacaoAceitoPorAdministrador ==
                          true)
                    '*Já justificada e já foi aceita por gerente e admininstrador'
                        .text
                        .size(14)
                        .center
                        .make()
                  else if (controller.presencaa.justificacaoAceitoPorGerente ==
                          false &&
                      controller.presencaa.justificacaoAceitoPorAdministrador ==
                          false)
                    '*Já justificada e já foi rejeitada por gerente e admininstrador'
                        .text
                        .size(14)
                        .center
                        .make()
                  else if (controller
                          .presencaa.justificacaoAceitoPorAdministrador ==
                      true)
                    '*Já justificada e já foi aceita por admininstrador'
                        .text
                        .size(14)
                        .center
                        .make()
                  else
                    '*Já justificada e já foi rejeitada por admininstrador'
                        .text
                        .size(14)
                        .center
                        .make(),
                  if ((!controller.presencaa.presente &&
                          controller.presencaa.justificada) &&
                      (Get.find<AppController>().usuario.tipo != 'Vendedor' &&
                          Get.find<AppController>().usuario.tipo != null))
                    [
                      IconButton(
                          icon: Icon(FontAwesomeIcons.raspberryPi),
                          onPressed: () {
                            Get.defaultDialog(
                                middleText:
                                    'Tens certeza que queres rejeitar a esta justificação?',
                                title: 'Aceitar Justificaçao',
                                onConfirm: () async {
                                  var tipo =
                                      Get.find<AppController>().usuario.tipo;
                                  if (tipo == "Admininstrador")
                                    controller.presencaa
                                            .justificacaoAceitoPorAdministrador =
                                        false;
                                  else
                                    controller.presencaa
                                        .justificacaoAceitoPorGerente = false;
                                  await controller
                                      .atualizarPresenca(controller.presencaa);
                                  Navigator.pop(Get.context);
                                  controller.pessoa.presencas
                                      .forEach((element) {
                                    if (element.id == controller.presencaa.id)
                                      element = controller.presencaa;
                                    controller.listarEmpregados();
                                  });
                                  Get.rawSnackbar(
                                      icon: Icon(FontAwesomeIcons.check),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Color(0xFF3CFEB5),
                                      messageText: Text(
                                        'Justificação rejeitada por ${tipo.toLowerCase()} com sucesso',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      borderRadius: 10,
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, bottom: 20));
                                });
                          }),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          icon: Icon(FontAwesomeIcons.checkCircle),
                          onPressed: () {
                            Get.defaultDialog(
                                middleText:
                                    'Tens certeza que queres aceitar a esta justificação?',
                                title: 'Aceitar Justificaçao',
                                onConfirm: () async {
                                  var tipo =
                                      Get.find<AppController>().usuario.tipo;
                                  if (tipo == "Admininstrador")
                                    controller.presencaa
                                            .justificacaoAceitoPorAdministrador =
                                        true;
                                  else
                                    controller.presencaa
                                        .justificacaoAceitoPorGerente = true;
                                  await controller
                                      .atualizarPresenca(controller.presencaa);
                                  Navigator.pop(Get.context);
                                  controller.pessoa.presencas
                                      .forEach((element) {
                                    if (element.id == controller.presencaa.id)
                                      element = controller.presencaa;
                                    controller.listarEmpregados();
                                  });
                                  Get.rawSnackbar(
                                      icon: Icon(FontAwesomeIcons.check),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Color(0xFF3CFEB5),
                                      messageText: Text(
                                        'Justificação aceita por ${tipo.toLowerCase()} com sucesso',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      borderRadius: 10,
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, bottom: 20));
                                });
                          })
                    ].row().centered()
                ],
              );
            },
            id: 'infoPresenca',
          ),
        ),
      ),
    );
  }

  Future<void> downloadFile(String url) async {
    // final http.Response downloadData = await http.get(url);
    // var bodyBytes = downloadData.bodyBytes;
    // File.fromRawPath(bodyBytes);
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Image.network(
          url,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

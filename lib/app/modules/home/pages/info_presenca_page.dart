import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class InfoPresencaPage extends GetView<HomeController> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    Presenca presenca = Get.arguments;
    if (presenca == null) {
      Navigator.pop(Get.context);
    }
    var dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: 'Informação da ${presenca.presente ? 'presença' : 'ausencia'}'
            .text
            .make(),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            GetBuilder<HomeController>(
              builder: (_) {
                print(presenca.nomeAudio);
                return presenca.presente
                    ? Container(
                        width: 200,
                        height: 300,
                        child: presenca.nomeFoto != null
                            ? Image.network(
                                presenca.nomeFoto,
                                fit: BoxFit.contain,
                              )
                            : Container(),
                      )
                    : Column(
                        children: [
                          presenca.nomeAudio.isNotBlank
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
                                            audioPlayer.play(presenca.nomeAudio,
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
                'Data da  ${presenca.presente ? 'presença' : 'ausencia'}:'
                    .text
                    .size(18)
                    .color(presenca.presente
                        ? Colors.greenAccent
                        : presenca.justificacaoAceitoPorAdministrador == true
                            ? Colors.lightGreenAccent
                            : presenca.justificacaoAceitoPorGerente == true
                                ? Colors.lightBlueAccent
                                : presenca.justificada
                                    ? Colors.deepOrangeAccent
                                    : Colors.redAccent)
                    .make(),
                '${dateFormat.format(presenca.dataCriacao)}'
                    .text
                    .size(20)
                    .color(presenca.presente
                        ? Colors.greenAccent
                        : presenca.justificacaoAceitoPorAdministrador == true
                            ? Colors.lightGreenAccent
                            : presenca.justificacaoAceitoPorGerente == true
                                ? Colors.lightBlueAccent
                                : presenca.justificada
                                    ? Colors.deepOrangeAccent
                                    : Colors.redAccent)
                    .make(),
              ],
            ),
            if (presenca.presente)
              '*Esteve presente'.text.size(14).center.make()
            else if (!presenca.justificada)
              '*Ainda não foi justificada'.text.size(14).center.make()
            else if (presenca.justificacaoAceitoPorGerente == null)
              '*Já justificada mais ainda não foi aceita por gerente'
                  .text
                  .size(14)
                  .center
                  .make()
            else if (presenca.justificacaoAceitoPorAdministrador == null)
              '*Já justificada e já foi aceita por gerente, mais ainda não'
                      ' foi aceita por administrador'
                  .text
                  .size(14)
                  .center
                  .make()
            else
              '*Já justificada e já foi aceita por gerente e admininstrador'
                  .text
                  .size(14)
                  .center
                  .make(),
            if((!presenca.presente&&presenca.justificada))
            [
              IconButton(
                  icon: Icon(FontAwesomeIcons.raspberryPi),
                  onPressed: () {
                    Get.defaultDialog(
                        middleText:
                            'Tens certeza que queres rejeitar a esta justificação?',
                        title: 'Aceitar Justificaçao',
                        onConfirm: () {
                          Navigator.pop(Get.context);
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
                        onConfirm: () {
                          Navigator.pop(Get.context);
                        });
                  })
            ].row().centered(),
          ],
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

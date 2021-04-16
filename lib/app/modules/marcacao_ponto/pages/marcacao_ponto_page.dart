import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/modules/marcacao_ponto/controllers/marcacao_ponto_controller.dart';
import 'package:lpbp/app/res/static.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../app_controller.dart';

class MarcacaoPontoPage extends GetView<MarcacaoPontoController> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  final textEditingControl = TextEditingController();

  Future getImage() async {
    File image = await ImagePickerGC.pickImage(
        context: Get.context,
        source: ImgSource.Camera,
        cameraIcon: Icon(
          Icons.camera_alt,
          color: Colors.red,
        ),
        cameraText: Text(
          "Camera",
          style: TextStyle(color: Colors.red),
        ),
        galleryText: Text(
          "Galleria",
          style: TextStyle(color: Colors.blue),
        ));
    controller.image = image.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Marcar Ponto"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
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
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 175,
                          ),
                          Container(
                            width: 200,
                            height: 200,
                            child: Stack(
                              children: [
                                Container(
                                  height: 140,
                                  width: 140,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFf2f3fe),
                                      borderRadius: BorderRadius.circular(110)),
                                  child: GetBuilder<MarcacaoPontoController>(
                                    builder: (_) {
                                      CircleAvatar(
                                        backgroundImage:
                                            FileImage(File(controller.image)),
                                      );
                                      return controller.image != ""
                                          ? Container(
                                              width: 140,
                                              height: 140,
                                              child: CircleAvatar(
                                                backgroundImage: FileImage(
                                                    File(controller.image)),
                                              ),
                                            )
                                          : Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 120,
                                            );
                                    },
                                  ),
                                ),
                                Positioned(
                                  bottom: 65,
                                  right: 65,
                                  top: 100,
                                  child: GestureDetector(
                                    onTap: () {
                                      // if(GetPlatform.isWeb) getImageWeb();
                                      // else
                                      getImage();
                                    },
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 4, 125, 141),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 300,
                            decoration: ShapeDecoration(
                              color: Color(0xFFEFF0F2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            child: TextField(
                              controller: textEditingControl,
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
                                          borderRadius:
                                              BorderRadius.circular(9)),
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
                      width: Get.width,
                      margin: EdgeInsets.symmetric(horizontal: 100),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 0,
                        color: Color.fromARGB(255, 4, 125, 141),
                        onPressed: () async {
                          validarForm();
                        },
                        child: 'Bater Ponto'.text.white.make(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  validarForm() async {
    // controller.image.isNotEmpty &&
    var find = Get.find<AppController>();
    if (controller.presenca.codigo.isNotEmpty) {
      var filtrarPorCodigo = find.filtrarPorCodigo(controller.presenca.codigo);
      var dateTime = DateTime.now();
      if (filtrarPorCodigo.isNull) {
        Get.rawSnackbar(
            icon: Icon(
              FontAwesomeIcons.eraser,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFFFE3C3C),
            messageText: Text(
              'Não existe funcionario com este codigo',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
      }
      if (((dateTime.hour > 13 ||
                  (dateTime.hour == 13 && dateTime.minute > 29)) &&
              filtrarPorCodigo.pessoa.turno == 'MANHA') ||
          ((dateTime.hour < 13 ||
                  (dateTime.hour == 13 && dateTime.minute <= 30)) &&
              filtrarPorCodigo.pessoa.turno == 'TARDE')) {
        Get.rawSnackbar(
            icon: Icon(
              FontAwesomeIcons.eraser,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFFFE3C3C),
            messageText: Text(
              'Não podes marcar ponto agora porque não pertences a este turno',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
      } else {
        var nomeCompleto =
            '${filtrarPorCodigo.nome} ${filtrarPorCodigo.pessoa.apelido}';
        var dateTime = DateTime.now();
        var nomeFoto =
            '${nomeCompleto}_${dateTime.year}-${dateTime.month}-${dateTime.day}_${dateTime.hour}:${dateTime.minute}';
        var firstWhere = find.listPresenca.firstWhere(
            (element) => element.codigo == textEditingControl.text,
            orElse: () => null);
        if (firstWhere == null) {
          var saveArquiv =
              await saveArquivo("imagens/$nomeFoto", controller.image);
          controller.presenca.codigo = textEditingControl.text;
          controller.presenca.nomeFoto = saveArquiv;
          await find.salvarPresenca(controller.presenca);
          controller.presenca = Presenca();
          controller.image = '';
          textEditingControl.text = '';
          Get.rawSnackbar(
              icon: Icon(FontAwesomeIcons.check),
              duration: Duration(seconds: 2),
              backgroundColor: Color(0xFF3CFEB5),
              messageText:
                  '$nomeCompleto presente'.text.bold.white.size(18).make(),
              borderRadius: 10,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
        } else {
          Get.rawSnackbar(
              icon: Icon(
                FontAwesomeIcons.eraser,
                color: Colors.white,
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Color(0xFFFE3C3C),
              messageText: '$nomeCompleto já foi marcada como presente'
                  .text
                  .bold
                  .white
                  .size(18)
                  .make(),
              borderRadius: 10,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
        }
      }
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
            'Deves tirar foto e preencher o campo com a sua senha',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          borderRadius: 10,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
      Future.delayed(Duration(seconds: 2), () {});
    }
  }
}

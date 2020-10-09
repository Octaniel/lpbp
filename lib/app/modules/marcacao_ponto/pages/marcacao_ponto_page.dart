import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:lpbp/app/modules/marcacao_ponto/controllers/marcacao_ponto_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class MarcacaoPontoPage extends GetView<MarcacaoPontoController> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  Future getImage() async {
    File image = await ImagePickerGC.pickImage(
        context: Get.context,
        source: ImgSource.Gallery,
        cameraIcon: Icon(
          Icons.camera_alt,
          color: Colors.red,
        ),
        //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
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
        title: Text("From Camera"),
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
                              child: GetBuilder<HomeController>(
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
                                  getImage();
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 4, 125, 141),
                                      borderRadius: BorderRadius.circular(30)),
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
                            controller.senha = v;
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
                    onPressed: () {
                      // validarForm();
                      assetsAudioPlayer.playOrPause();
                    },
                    child: 'Bater Ponto'.text.white.make(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  validarForm() async {
    if (controller.image.isNotEmpty && controller.senha.isNotEmpty) {
      Get.rawSnackbar(
          icon: Icon(FontAwesomeIcons.check),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFF3CFEB5),
          messageText: Text(
            'Marcaste de ponto com sucesso',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          borderRadius: 10,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
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

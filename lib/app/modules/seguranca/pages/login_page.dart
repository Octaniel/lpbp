import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpbp/app/routes/app_routes.dart';
import 'package:lpbp/app/widgets/text_input_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../app_controller.dart';
import '../controllers/seguranca_controller.dart';

class LoginPage extends GetView<SegurancaController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 5, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  'BEM VINDO AO E-DOBRA'.text.center.size(20).semiBold.make(),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          TextInputWidget(
                              false,
                              Icons.email,
                              'Email',
                                  (value) => !controller.email.contains('@') ||
                                  !controller.email.contains('.')
                                  ? 'Email invalido'
                                  : null,
                              TextInputType.emailAddress,
                                  (value) => controller.email = value),
                          SizedBox(
                            height: 20,
                          ),
                          TextInputWidget(
                              true,
                              Icons.lock,
                              'Senha',
                                  (value) => controller.senha.length < 1
                                  ? 'Senha tem no minimo 6 caracter'
                                  : null,
                              TextInputType.text,
                                  (value) => controller.senha = value),
                          SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: 'Esqueci senha'
                                  .text
                                  .size(14)
                                  .color(Color(0xFF575E63))
                                  .make(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 47,
                            width: MediaQuery.of(context).size.width,
                            child: GetBuilder<SegurancaController>(
                              builder: (_) {
                                return RaisedButton(
                                  disabledColor: Color(0xFF3C63FE).withOpacity(.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  color: Color(0xFF3C63FE),
                                  onPressed:
                                  !controller.circularProgressButaoRegistrar
                                      ? () {
                                    validarForm();
                                  }
                                      : null,
                                  child: !controller.circularProgressButaoRegistrar
                                      ? 'LOGIN'
                                      .text
                                      .color(Colors.white)
                                      .size(14)
                                      .make()
                                      : CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  validarForm() async {
    if (formKey.currentState.validate()) {
      controller.circularProgressButaoRegistrar = true;
      if (await controller.logar()) {
        Get.find<AppController>().refreshUsuario();
        Get.rawSnackbar(
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF3CFEB5),
            messageText:
                'Bem vindo'.text.color(Colors.white).size(15).bold.make(),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
        Future.delayed(Duration(seconds: 2), () {
          controller.circularProgressButaoRegistrar = false;
          Get.offAllNamed(Routes.HOME);
        });
      } else {
        Get.rawSnackbar(
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFFFE3C3C),
            messageText: 'Senha ou E-mail Invalido'
                .text
                .color(Colors.white)
                .size(15)
                .bold
                .make(),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
        Future.delayed(Duration(seconds: 2), () {
          controller.circularProgressButaoRegistrar = false;
        });
      }
    }
  }
}

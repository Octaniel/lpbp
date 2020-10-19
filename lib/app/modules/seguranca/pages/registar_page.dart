import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lpbp/app/modules/seguranca/controllers/seguranca_controller.dart';
import 'package:lpbp/app/widgets/text_input_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class RegistrarPage extends GetView<SegurancaController> {
  final formKeyRegistar = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Image.asset(
              'image/icon.png',
              height: 86,
              width: 86,
            ),
            SizedBox(
              height: 10,
            ),
            'CRIAR CONTA'.text.center.size(20).semiBold.make(),
            SizedBox(
              height: 30,
            ),
            Form(
              key: formKeyRegistar,
              child: Column(
                children: [
                  TextInputWidget(
                      false,
                      Icons.person,
                      'Nome Completo',
                      (value) => !controller.pessoa.nome.contains(' ') &&
                              controller.pessoa.nome.length < 6
                          ? 'Por favor digita seu nome completo'
                          : null,
                      TextInputType.name, (value) {
                    controller.pessoa.nome = value;
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputWidget(
                      false,
                      Icons.email,
                      'Email',
                      (value) => !controller.pessoa.email.contains('@') &&
                              !controller.pessoa.email.contains('.')
                          ? 'Email invalido'
                          : null,
                      TextInputType.emailAddress, (value) {
                    controller.pessoa.email = value;
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputWidget(
                      false,
                      FontAwesomeIcons.solidAddressBook,
                      'Morada',
                      (value) => controller.pessoa.morada.length < 4
                          ? 'Morada deve ter no minimo 4 caracteres'
                          : null,
                      TextInputType.streetAddress, (value) {
                    controller.pessoa.morada = value;
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputWidget(
                      false,
                      Icons.phone_android,
                      'Número Télemovel',
                      (value) => controller.pessoa.telemovel.length < 7
                          ? 'Número Télemovel deve ter no minimo 7 caracteres'
                          : null,
                      TextInputType.number, (value) {
                    controller.pessoa.telemovel = value;
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputWidget(
                      true,
                      Icons.lock,
                      'Senha',
                      (value) => controller.usuario.senha.length < 6
                          ? 'Senha deve ter no minimo 6 caracteres'
                          : null,
                      TextInputType.visiblePassword, (value) {
                    controller.usuario.senha = value;
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 47,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      color: Color(0xFF3C63FE),
                      onPressed: () {
                        validarForm();
                      },
                      child: GetBuilder<SegurancaController>(builder: (v) {
                        return !controller.circularProgressButaoRegistrar
                            ? 'REGISTAR'
                                .text
                                .color(Colors.white)
                                .size(14)
                                .make()
                            : CircularProgressIndicator();
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  validarForm() async {
    if (formKeyRegistar.currentState.validate()) {
      controller.circularProgressButaoRegistrar = true;
      if (await controller.salvarUsuario()) {
        Get.rawSnackbar(
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF3CFEB5),
            messageText: 'Registado com sucesso'
                .text
                .color(Colors.white)
                .size(15)
                .bold
                .make(),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
        Future.delayed(Duration(seconds: 2), () {
          controller.circularProgressButaoRegistrar = false;
          // Get.offAndToNamed(Routes.LOGIN);
        });
      } else {
        Get.rawSnackbar(
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFFFE3C3C),
            messageText: 'Falha ao Registar'
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

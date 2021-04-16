import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lpbp/app/data/provider/auth_provider.dart';
import 'package:lpbp/app/routes/app_routes.dart';
import 'package:lpbp/app/widgets/text-form-widget.dart';
import 'package:lpbp/app/widgets/text-widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../app_controller.dart';
import '../controllers/seguranca_controller.dart';

class LoginPage extends GetView<SegurancaController> {
  final formKey = GlobalKey<FormState>();

  Future verificarToken() {
    Future.delayed(Duration(seconds: 2), () async {
      if (await AuthProvider().verificarERenovarToken()) {
        await Get.find<AppController>().refreshUsuario();
        Get.offNamed(Routes.HOME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    verificarToken();
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextWidget(
                text: GetPlatform.isWeb?'LPDP ADMIN':'LPDP',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, .2),
                        blurRadius: 20.0,
                        offset: Offset(0, 10))
                  ]),
              width: 300,
              height: GetPlatform.isWeb?270:312,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                        autofillHints: [AutofillHints.username, AutofillHints.email],
                        label: 'E-mail',
                        onChanged: (v) => controller.email = v,
                        isObscure: false,
                        icon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          var email = controller.email;
                          if (GetUtils.isNullOrBlank(email))
                            return "Preencha o seu e-mail";
                          if (!GetUtils.isEmail(email))
                            return "E-mail inválido";
                          return null;
                        }),
                    TextFormFieldWidget(
                      autofillHints: [AutofillHints.password],
                      onFieldSubmitted: (v){
                        validarForm();
                      },
                        label: 'Senha',
                        onChanged: (v) => controller.senha = v,
                        isObscure: true,
                        icon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        inputType: TextInputType.visiblePassword,
                        validator: (value) {
                          var senha = controller.senha;
                          if (GetUtils.isNullOrBlank(senha))
                            return "Preencha a sua senha";
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: Get.width - 30,
                      height: 40,
                      child: RaisedButton(
                          color: Colors.grey[300],
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: Obx(
                                      () => controller.circularProgressButaoRegistrar
                                      ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                      : TextWidget(
                                    text: "LOGAR",
                                    color: Colors.black,
                                  ),
                                )),
                          ),
                          onPressed: !controller.circularProgressButaoRegistrar
                              ? () {
                            validarForm();
                          }
                              : null),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // GetPlatform.isWeb?Text(''):
                  ],
                ),
              ),
            ),
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
        Get.snackbar("", "",
            titleText: 'Sucesso'
                .text
                .color(Colors.white)
                .size(16)
                .bold
                .make(),
            snackPosition: SnackPosition.BOTTOM,
            messageText: 'Bem vindo'.text.color(Colors.white).size(15).bold.make(),
            icon: Icon(
              FontAwesomeIcons.check,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF3CFEB5),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
        Future.delayed(Duration(seconds: 2), () {
          controller.circularProgressButaoRegistrar = false;
          Get.offAndToNamed(Routes.HOME);
        });
      } else {
        Get.snackbar("", "",
            titleText: 'Erro'
                .text
                .color(Colors.white)
                .size(16)
                .bold
                .make(),
            snackPosition: SnackPosition.BOTTOM,
            messageText: 'Senha ou E-mail Invalido'
                .text
                .color(Colors.white)
                .size(15)
                .bold
                .make(),
            icon: Icon(
              FontAwesomeIcons.times,
              color: Colors.white,
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFFFE3C3C),
            borderRadius: 10,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
        Future.delayed(Duration(seconds: 2), () {
          controller.circularProgressButaoRegistrar = false;
        });
      }
    }
  }
}

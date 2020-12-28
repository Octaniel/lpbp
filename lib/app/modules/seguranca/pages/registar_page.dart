import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lpbp/app/modules/seguranca/controllers/seguranca_controller.dart';
import 'package:lpbp/app/widgets/text-form-widget.dart';
import 'package:lpbp/app/widgets/text-widget.dart';
import 'package:velocity_x/velocity_x.dart';

class RegistrarPage extends GetView<SegurancaController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: Get.height*.2,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextWidget(
                    text: 'FEEDFOOD',
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
                  height: 426,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormFieldWidget(
                            label: 'Nome',
                            onChanged: (v) => controller.pessoa.nome = v,
                            isObscure: false,
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            inputType: TextInputType.name,
                            validator: (value) {
                              var nome = controller.pessoa.nome;
                              if (GetUtils.isNullOrBlank(nome))
                                return "Preencha o seu nome";
                              return null;
                            }),
                        TextFormFieldWidget(
                            label: 'Sobrenome',
                            onChanged: (v) => controller.pessoa.apelido = v,
                            isObscure: false,
                            icon: Icon(
                              FontAwesomeIcons.personBooth,
                              color: Colors.black,
                            ),
                            inputType: TextInputType.name,
                            validator: (value) {
                              var nome = controller.pessoa.apelido;
                              if (GetUtils.isNullOrBlank(nome))
                                return "Preencha o seu Sobrenome";
                              return null;
                            }),
                        TextFormFieldWidget(
                            label: 'Telemovel',
                            onChanged: (v) => controller.pessoa.telemovel = v,
                            isObscure: false,
                            icon: Icon(
                              FontAwesomeIcons.mobile,
                              color: Colors.black,
                            ),
                            inputType: TextInputType.number,
                            validator: (value) {
                              var nome = controller.pessoa.telemovel;
                              if (GetUtils.isNullOrBlank(nome))
                                return "Preencha o seu Telemovel";
                              return null;
                            }),
                        TextFormFieldWidget(
                            label: 'E-mail',
                            onChanged: (v) => controller.pessoa.email = v,
                            isObscure: false,
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            inputType: TextInputType.emailAddress,
                            validator: (value) {
                              var email = controller.pessoa.email;
                              if (GetUtils.isNullOrBlank(email))
                                return "Preencha o seu e-mail";
                              if (!GetUtils.isEmail(email))
                                return "E-mail inválido";
                              return null;
                            }),
                        TextFormFieldWidget(
                            label: 'Senha',
                            onChanged: (v) => controller.usuario.senha = v,
                            isObscure: true,
                            icon: Icon(
                              Icons.lock_outline,
                              color: Colors.black,
                            ),
                            inputType: TextInputType.text,
                            validator: (value) {
                              var senha = controller.usuario.senha;
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
                                        text: "REGISTRAR",
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  validarForm() async {
    if (formKey.currentState.validate()) {
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
          icon: Icon(FontAwesomeIcons.times, color: Colors.white,),
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

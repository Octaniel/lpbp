import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lpbp/app/app_controller.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:lpbp/app/routes/app_routes.dart';
import 'package:lpbp/app/widgets/text-form-widget.dart';
import 'package:lpbp/app/widgets/text-widget.dart';
import 'package:velocity_x/velocity_x.dart';

class RegistrarPage extends GetView<HomeController> {
  final textEditingControler1 = TextEditingController();
  final textEditingControler2 = TextEditingController();
  final textEditingControler3 = TextEditingController();
  final textEditingControler4 = TextEditingController();
  final textEditingControler5 = TextEditingController();
  final textEditingControler6 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (controller.pessoa.id != null) {
      textEditingControler1.text = controller.pessoa.nome;
      textEditingControler2.text = controller.pessoa.apelido;
      textEditingControler3.text = controller.pessoa.morada;
      textEditingControler4.text = controller.pessoa.telemovel;
      textEditingControler5.text = controller.pessoa.email;
      textEditingControler6.text = controller.usuario.senha;
    }
    return Scaffold(
      appBar: AppBar(
        title: 'Registar funcionario'.text.make(),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: Get.height * .2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextWidget(
                    text: 'LPDB',
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
                  height: 546,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormFieldWidget(
                            controller: textEditingControler1,
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
                            controller: textEditingControler2,
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
                            controller: textEditingControler3,
                            label: 'Morada',
                            onChanged: (v) => controller.pessoa.morada = v,
                            isObscure: false,
                            icon: Icon(
                              FontAwesomeIcons.personBooth,
                              color: Colors.black,
                            ),
                            inputType: TextInputType.name,
                            validator: (value) {
                              var nome = controller.pessoa.apelido;
                              if (GetUtils.isNullOrBlank(nome))
                                return "Preencha o morada";
                              return null;
                            }),
                        Row(
                          children: [
                            'Tipo de Usuario:'.text.semiBold.make(),
                            SizedBox(
                              width: 10,
                            ),
                            VxTextDropDown(
                                    ['Admininstrador', 'Gerente', 'Vendedor'],
                                    selectedValue: controller.usuario.tipo,
                                    onChanged: (v) {
                              print(v);
                              controller.usuario.tipo = v;
                            })
                                .elevation(5)
                                .icon(
                                  Icon(Icons.arrow_drop_down_circle_outlined),
                                )
                                .make(),
                          ],
                        ),
                        // DropdownButton(
                        //   items: [
                        //     DropdownMenuItem(
                        //       child: 'Admin'.text.make(),
                        //     ),
                        //     DropdownMenuItem(
                        //       child: 'Gerente'.text.make(),
                        //     ),
                        //     DropdownMenuItem(
                        //       child: 'Vendedor'.text.make(),
                        //     ),
                        //   ],
                        //   onChanged: (v) {
                        //     print(v);
                        //   },
                        //   selectedItemBuilder: (_){
                        //     return ['oooo'.text.make()];
                        //   },
                        // ),
                        TextFormFieldWidget(
                            controller: textEditingControler4,
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
                            controller: textEditingControler5,
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
                        if (controller.pessoa.id == null)
                          TextFormFieldWidget(
                              controller: textEditingControler6,
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
                                  () => controller
                                          .circularProgressButaoRegistrar
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : TextWidget(
                                          text: "REGISTRAR",
                                          color: Colors.black,
                                        ),
                                )),
                              ),
                              onPressed:
                                  !controller.circularProgressButaoRegistrar
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
       await Get.find<AppController>().listarEmpregados();
        controller.listarEmpregados();
        Future.delayed(Duration(seconds: 2), () {
          controller.circularProgressButaoRegistrar = false;
          Get.offAndToNamed(Routes.LISTAFUNCIONARIO);
        });
      } else {
        Get.rawSnackbar(
            icon: Icon(
              FontAwesomeIcons.times,
              color: Colors.white,
            ),
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

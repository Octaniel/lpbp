import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lpbp/app/app_controller.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:lpbp/app/routes/app_routes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends GetView<HomeController> {
  bool v = true;

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 3), () {
    //   Get.defaultDialog(
    //     title: 'Processando',
    //     content: CircularProgressIndicator(
    //       valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
    //     ),
    //   );
    // });

    return Scaffold(
      appBar: AppBar(
        title: 'Home'.text.size(30).make(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<AppController>(
                builder: (_) {
                  return Get.find<AppController>().logado == true
                      ? Column(
                          children: [
                            containerCustom('MARCAR', Routes.MARCAPONTO),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : Container();
                },
                id: 'mostrarLogin',
              ),
              containerCustom('STATUS', Routes.DETALHEMPREGADO),
              SizedBox(
                height: 20,
              ),
              containerCustom('ATUALIZAR', ''),
              SizedBox(
                height: 20,
              ),
              containerCustom('COMUNICAR', ''),
              SizedBox(
                height: 20,
              ),
              GetBuilder<AppController>(
                builder: (_) {
                  return Visibility(
                    visible: Get.find<AppController>().usuario.tipo ==
                        'Admininstrador',
                    replacement: ''.text.make(),
                    child: AnimatedContainer(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      duration: Duration(seconds: 2),
                      child: containerCustom(
                          'REGISTRAR FUNCIONARIO', Routes.REGISTRAR),
                    ),
                  );
                },
                id: 'mostrarLogin',
              ),
              SizedBox(
                height: 40,
              ),
              GetBuilder<AppController>(
                builder: (_) {
                  return Visibility(
                    visible: Get.find<AppController>().logado,
                    replacement: ''.text.make(),
                    child: AnimatedContainer(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      duration: Duration(seconds: 2),
                      child: containerCustom('LOGOUT', Routes.REGISTRAR),
                    ),
                  );
                },
                id: 'mostrarLogin',
              ),
              SizedBox(
                height: 40,
              ),
              GetBuilder<AppController>(
                builder: (_) {
                  return Visibility(
                    visible: !Get.find<AppController>().logado,
                    replacement: ''.text.make(),
                    child: AnimatedContainer(
                      height: 60,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      duration: Duration(seconds: 2),
                      child: containerCustom('LOGAR', Routes.LOGIN),
                    ),
                  );
                },
                id: 'mostrarLogin',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget containerCustom(String label, String rota) {
    return GestureDetector(
      onTap: () async {
        if (label == 'ATUALIZAR') {
          var appController = Get.find<AppController>();
          Get.defaultDialog(
            title: 'Processando',
            content: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
            ),
          );
          // var i = await appController.listarEmpregados(true);
          await appController.testSave();
          Navigator.pop(Get.context);
          // if (i == 1) {
          //   Get.defaultDialog(
          //       title: 'Lista de funcionarios atualizados',
          //       content: Icon(
          //         FontAwesomeIcons.check,
          //         color: Colors.greenAccent,
          //         size: 40,
          //       ));
          // } else {
          //   Get.defaultDialog(
          //       title: 'Erro ao atualizar lista de funcionarios',
          //       content: Icon(
          //         FontAwesomeIcons.times,
          //         color: Colors.redAccent,
          //         size: 40,
          //       ));
          // }
        } else if (label == 'COMUNICAR') {
          Get.defaultDialog(
            title: 'Teu Codigo',
            onConfirm: () async {
              if (controller.presenca.codigo.isNotBlank) {
                var filtrarPorCodigo = Get.find<AppController>()
                    .filtrarPorCodigo(controller.presenca.codigo);
                if (filtrarPorCodigo == null) {
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
                } else {
                  if (filtrarPorCodigo.tipo == 'Vendedor') {
                    Navigator.pop(Get.context);
                  } else {
                    Navigator.pop(Get.context);
                    Get.defaultDialog(
                      title: 'Processando',
                      content: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                      ),
                    );
                    var i =
                        await Get.find<AppController>().salvarTodasPresencas();
                    Navigator.pop(Get.context);
                    if (i == 1) {
                      Get.defaultDialog(
                          title: 'Todas presenças salvas no servidor',
                          content: Icon(
                            FontAwesomeIcons.check,
                            color: Colors.greenAccent,
                            size: 40,
                          ));
                    } else {
                      Get.defaultDialog(
                          title: 'Erro ao salvar presenças no servidor',
                          content: Icon(
                            FontAwesomeIcons.times,
                            color: Colors.redAccent,
                            size: 40,
                          ));
                    }
                  }
                }
              }
            },
            content: TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              obscuringCharacter: '#',
              onChanged: (v) {
                controller.presenca.codigo = v;
              },
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(15)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(15)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  prefixIcon: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
          );
        } else if (label == 'MARCAR') {
          // Get.toNamed(Routes.MARCAPONTO);
          if (!await controller.registar()) {
            Get.rawSnackbar(
                icon: Icon(
                  FontAwesomeIcons.erlang,
                  color: Colors.white,
                ),
                duration: Duration(seconds: 2),
                backgroundColor: Color(0xFFFE3C3C),
                messageText: Text(
                  'Erro no servidor, por favor contacte o admininstrador do sistema',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                borderRadius: 10,
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20));
          }
        } else if (label == 'LOGOUT') {
          if (await Get.find<AppController>().logout()) {
            Get.find<AppController>().logado = false;
          }
        } else if (rota == Routes.DETALHEMPREGADO) {
          if (Get.find<AppController>().usuario.tipo == 'Vendedor') {
            var filtrarPorCodigo = Get.find<AppController>().filtrarPorCodigo(
                Get.find<AppController>().usuario.pessoa.codigo);
            Get.toNamed(rota, arguments: filtrarPorCodigo);
          } else if (Get.find<AppController>().usuario.tipo ==
                  'Admininstrador' ||
              Get.find<AppController>().usuario.tipo == 'Gerente') {
            Get.toNamed(Routes.LISTAFUNCIONARIO);
          } else {
            Get.defaultDialog(
              title: 'Teu Codigo',
              onConfirm: () {
                if (controller.presenca.codigo.isNotBlank) {
                  var filtrarPorCodigo = Get.find<AppController>()
                      .filtrarPorCodigo(controller.presenca.codigo);
                  if (filtrarPorCodigo == null) {
                    Get.rawSnackbar(
                        icon: Icon(
                          FontAwesomeIcons.eraser,
                          color: Colors.white,
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: Color(0xFFFE3C3C),
                        messageText: Text(
                          'Não existe funcioanio com este codigo',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        borderRadius: 10,
                        margin:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20));
                  } else {
                    controller.pessoa = filtrarPorCodigo.pessoa;
                    Navigator.pop(Get.context);
                    Get.toNamed(rota, arguments: filtrarPorCodigo);
                  }
                }
              },
              content: TextField(
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
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    prefixIcon: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
            );
          }
        } else
          Get.toNamed(rota);
      },
      child: AnimatedContainer(
        height: 80,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [Colors.greenAccent, Colors.blue]),
        ),
        duration: Duration(seconds: 2),
        child: label.text.center.bold.white.size(70).make(),
      ),
    );
  }
}

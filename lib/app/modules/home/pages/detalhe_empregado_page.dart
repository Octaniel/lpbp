import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lpbp/app/app_controller.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:lpbp/app/routes/app_routes.dart';
import 'package:velocity_x/velocity_x.dart';

class DetalheEmpregadoPage extends GetView<HomeController> {
  final f = new DateFormat('dd/MM/yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    // Pessoa arguments = Get.arguments;
    // if(arguments==null){
    //   Navigator.pop(Get.context);
    // }
    return Scaffold(
      appBar: AppBar(
        title: 'Pontos'.text.make(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            if (controller.pessoa.presencas != null)
              Column(
                children: controller.pessoa.presencas
                    .map((e) => InkWell(
                          onTap: () {
                            // Get.toNamed(Routes.DETALHEMPREGADO, arguments: e);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 60,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 3,
                              child: GetBuilder<HomeController>(
                                builder: (_) {
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Tooltip(
                                        message: e.presente
                                            ? 'Estavas presente'
                                            : 'Faltaste',
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: e.presente
                                                  ? Colors.greenAccent
                                                  : e.justificacaoAceitoPorAdministrador ==
                                                          true
                                                      ? Colors.orangeAccent
                                                      : Colors.redAccent,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      f
                                          .format(e.dataCriacao)
                                          .text
                                          .size(18)
                                          .bold
                                          .make(),
                                      Spacer(
                                        flex: 100,
                                      ),
                                      Visibility(
                                        visible: Get.find<AppController>()
                                                    .usuario
                                                    .tipo !=
                                                'Vendedor' &&
                                            Get.find<AppController>()
                                                    .usuario
                                                    .tipo !=
                                                null,
                                        replacement: ''.text.make(),
                                        child: Tooltip(
                                          message: 'Mais Sobre',
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.presencaa = e;
                                              Get.toNamed(Routes.INFOPRESENCA);
                                            },
                                            child: Container(
                                              child: Icon(
                                                FontAwesomeIcons.info,
                                                color: Colors.black87,
                                              ),
                                              width: 50,
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      e.presente
                                          ? ''.text.make()
                                          : e.justificada &&
                                                  e.justificacaoAceitoPorGerente ==
                                                      null &&
                                                  e.justificacaoAceitoPorAdministrador ==
                                                      null
                                              ? Tooltip(
                                                  message:
                                                      'Justificado, mais esperando gerente',
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Icon(
                                                        FontAwesomeIcons
                                                            .signature,
                                                        color:
                                                            Colors.deepOrange),
                                                  ),
                                                )
                                              : e.justificada &&
                                                      e.justificacaoAceitoPorGerente ==
                                                          true &&
                                                      e.justificacaoAceitoPorAdministrador ==
                                                          null
                                                  ? Tooltip(
                                                      message:
                                                          'Justificado, já aceito por gerente',
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: Icon(
                                                            FontAwesomeIcons
                                                                .signLanguage,
                                                            color: Colors
                                                                .deepOrangeAccent),
                                                      ),
                                                    )
                                                  : e.justificada &&
                                                          e
                                                              .justificacaoAceitoPorAdministrador
                                                      ? Tooltip(
                                                          message:
                                                              'Justificado, e aceito',
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {},
                                                            child: Icon(
                                                                FontAwesomeIcons
                                                                    .check,
                                                                color: Colors
                                                                    .greenAccent),
                                                          ),
                                                        )
                                                      : e.justificada &&
                                                              (e.justificacaoAceitoPorGerente ==
                                                                      false ||
                                                                  e.justificacaoAceitoPorAdministrador ==
                                                                      false)
                                                          ? Tooltip(
                                                              message:
                                                                  'Justificado, e rejeitado',
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {},
                                                                child: Icon(
                                                                    FontAwesomeIcons
                                                                        .times,
                                                                    color: Colors
                                                                        .redAccent),
                                                              ),
                                                            )
                                                          : Get.find<AppController>()
                                                                          .usuario
                                                                          .tipo !=
                                                                      'Vendedor' &&
                                                                  Get.find<AppController>()
                                                                          .usuario
                                                                          .tipo !=
                                                                      null
                                                              ? Tooltip(
                                                                  message:
                                                                      'Ainda não foi justificado',
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap:
                                                                        () {},
                                                                    child: Icon(
                                                                        FontAwesomeIcons
                                                                            .commentSlash,
                                                                        color: Colors
                                                                            .black87),
                                                                  ),
                                                                )
                                                              : Tooltip(
                                                                  message:
                                                                      'Justificar',
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      controller
                                                                          .presencaa = e;
                                                                      Get.toNamed(
                                                                          Routes
                                                                              .RECORDPAGE);
                                                                    },
                                                                    child: Icon(
                                                                      FontAwesomeIcons
                                                                          .indent,
                                                                      color: Colors
                                                                          .black87,
                                                                    ),
                                                                  ),
                                                                ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  );
                                },
                                id: 'pontos',
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lpbp/app/app_controller.dart';
import 'package:lpbp/app/data/model/pessoa.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:lpbp/app/routes/app_routes.dart';
import 'package:velocity_x/velocity_x.dart';

class DetalheEmpregadoPage extends GetView<HomeController> {
  final f = new DateFormat('dd/MM/yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    Pessoa arguments = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: 'Pontos'.text.make(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: arguments.presencas
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
                            child: Row(
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
                                            : Colors.redAccent,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                f.format(e.dataCriacao).text.size(18).bold.make(),
                                Spacer(
                                  flex: 100,
                                ),
                                Visibility(
                                  visible: Get.find<AppController>().usuario.grupo !='vendedor',
                                  replacement: ''.text.make(),
                                  child: Tooltip(
                                    message: 'Mais Sobre',
                                    child: GestureDetector(
                                      onTap: (){
                                        // Get.toNamed(Routes.RECORDPAGE, arguments: e);
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.info,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                e.presente
                                    ? ''.text.make()
                                    : e.justificada&&e.justificacaoAceitoPorGerente.isNull?Tooltip(
                                  message: 'Justificado, mais esperando gerente',
                                  child: GestureDetector(
                                    onTap: (){},
                                    child: Icon(FontAwesomeIcons.signature, color: Colors.deepOrange),
                                  ),
                                ):e.justificada&&e.justificacaoAceitoPorGerente&&e.justificacaoAceitoPorAdministrador.isNull?Tooltip(
                                  message: 'Justificado, já aceito por gerente',
                                  child: GestureDetector(
                                    onTap: (){},
                                    child: Icon(FontAwesomeIcons.signLanguage, color: Colors.deepOrangeAccent),
                                  ),
                                ):e.justificada&&e.justificacaoAceitoPorGerente&&e.justificacaoAceitoPorAdministrador?Tooltip(
                                  message: 'Justificado, e aceito',
                                  child: GestureDetector(
                                    onTap: (){},
                                    child: Icon(FontAwesomeIcons.check, color: Colors.greenAccent),
                                  ),
                                ):e.justificada&&!e.justificacaoAceitoPorGerente?Tooltip(
                                  message: 'Justificado, e rejeitado',
                                  child: GestureDetector(
                                    onTap: (){},
                                    child: Icon(FontAwesomeIcons.times, color: Colors.redAccent),
                                  ),
                                ):Get.find<AppController>().usuario.grupo !='vendedor'?Tooltip(
                                  message: 'Ainda não foi justificado',
                                  child: GestureDetector(
                                    onTap: (){},
                                    child: Icon(FontAwesomeIcons.commentSlash, color: Colors.black87),
                                  ),
                                ): Tooltip(
                                        message: 'Justificar',
                                        child: GestureDetector(
                                          onTap: (){
                                            Get.toNamed(Routes.RECORDPAGE, arguments: e);
                                          },
                                          child: Icon(
                                            FontAwesomeIcons.indent,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
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

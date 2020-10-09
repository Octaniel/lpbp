import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lpbp/app/data/model/pessoa.dart';
import 'package:velocity_x/velocity_x.dart';

class DetalheEmpregadoPage extends StatelessWidget {
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
                                e.presente
                                    ? ''.text.make()
                                    : Tooltip(
                                        message: 'Justificar',
                                        child: Icon(
                                          FontAwesomeIcons.indent,
                                          color: Colors.black87,
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

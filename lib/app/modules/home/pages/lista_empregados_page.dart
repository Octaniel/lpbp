import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpbp/app/app_controller.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:lpbp/app/routes/app_routes.dart';
import 'package:velocity_x/velocity_x.dart';

class ListaEmpregadosPage extends GetView<HomeController> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    assetsAudioPlayer.open(
      Audio("assets/audio/1.mp3"),
      autoStart: false,
    );
    return WillPopScope(
      onWillPop: () async {
        await Get.find<AppController>().listarEmpregados();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: 'Lista de funcionarios'.text.make(),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: [
              GetBuilder<AppController>(
                builder: (v) {
                  v.empregados.sort((a,b)=>a.pessoa.nome.compareTo(b.pessoa.nome));
                  return Center(
                    child: Wrap(
                      children: v.empregados
                          .map((e) => Container(
                                    width: e.tipo == 'Admininstrador'?130:120,
                                    height: 140,
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          e.pessoa.nome.text.size(18).bold.make(),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          e.pessoa.morada.selectableText
                                              .size(17)
                                              .make(),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          if (e.tipo == 'Admininstrador')
                                            e.tipo.selectableText.semiBold
                                                .size(16)
                                                .color(Colors.greenAccent)
                                                .make()
                                          else if (e.tipo == 'Gerente')
                                            e.tipo.selectableText.semiBold
                                                .size(17)
                                                .color(Colors.blueAccent)
                                                .make()
                                          else
                                            e.tipo.selectableText.semiBold
                                                .size(17)
                                                .color(Colors.orangeAccent)
                                                .make(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () {
                                                    controller.pessoa = e.pessoa;
                                                    controller.usuario = e;
                                                    Get.toNamed(Routes.REGISTRAR);
                                                  }),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              IconButton(
                                                  icon: Icon(Icons.more_horiz),
                                                  onPressed: () {
                                                    controller.pessoa = e.pessoa;
                                                    Get.toNamed(
                                                        Routes.DETALHEMPREGADO,
                                                        arguments: e);
                                                  }),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              //     InkWell(
                              //   onTap: () {
                              //     Get.toNamed(Routes.DETALHEMPREGADO, arguments: e);
                              //     // Get.toNamed(Routes.MARCAPONTO);
                              //   },
                              //   child: Container(
                              //     margin: EdgeInsets.symmetric(horizontal: 20),
                              //     height: 60,
                              //     child: Card(
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(10)),
                              //       elevation: 3,
                              //       child: Row(
                              //         children: [
                              //           SizedBox(
                              //             width: 20,
                              //           ),
                              //           e.nome.text.size(18).bold.make(),
                              //           SizedBox(
                              //             width: 10,
                              //           ),
                              //           e.morada.selectableText.size(17).make(),
                              //           Spacer(
                              //             flex: 100,
                              //           ),
                              //           Icon(Icons.arrow_forward_ios),
                              //           SizedBox(
                              //             width: 10,
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              )
                          .toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

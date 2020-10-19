import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: 'Lista de funcionarios'.text.make(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            GetBuilder<HomeController>(builder: (_) {
              print(controller.empregados.length);
              return Column(
                children: controller.empregados
                    .map((e) =>
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DETALHEMPREGADO, arguments: e);
                        // Get.toNamed(Routes.MARCAPONTO);
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
                              e.nome.text
                                  .size(18)
                                  .bold
                                  .make(),
                              SizedBox(
                                width: 10,
                              ),
                              e.morada.selectableText.size(17).make(),
                              Spacer(
                                flex: 100,
                              ),
                              Icon(Icons.arrow_forward_ios),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

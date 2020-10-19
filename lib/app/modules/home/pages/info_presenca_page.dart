
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/modules/home/controllers/home_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class InfoPresencaPage extends GetView<HomeController> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Presenca presenca = Get.arguments;
    var dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: 'Informação da presença(${presenca.presente?'Presente':'Ausente'})'.text.make(),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              width: 200,
              height: 300,
              child: Image.network(
                presenca.nomeFoto,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                'Data da Presenca:'.text.size(18).color(Colors.greenAccent).make(),
                '${dateFormat.format(presenca.dataCriacao)}'.text.size(20).color(Colors.greenAccent).make()
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> downloadFile(String url) async {
    // final http.Response downloadData = await http.get(url);
    // var bodyBytes = downloadData.bodyBytes;
    // File.fromRawPath(bodyBytes);
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Image.network(
          url,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

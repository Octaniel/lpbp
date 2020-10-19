import 'package:get/get.dart';
import 'package:lpbp/app/app_controller.dart';
import 'package:lpbp/app/data/model/pessoa.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/data/provider/seguranca_provider.dart';

class HomeController extends GetxController {
  final _empregados = List<Pessoa>().obs;
  final _audio = ''.obs;
  final _presenca = Presenca().obs;
  final _boxShadow = true.obs;

  bool get boxShadow => _boxShadow.value;

  set boxShadow(bool value) {
    _boxShadow.value = value;
    update(['boxShadow']);
  }

  Presenca get presenca => _presenca.value;

  set presenca(Presenca value) {
    _presenca.value = value;
  }

  String get audio => _audio.value;

  set audio(String value) {
    _audio.value = value;
    update(['playReplay']);
  }

  HomeController(){
    listarEmpregados();
  }

  List<Pessoa> get empregados => _empregados.value;

  set empregados(List<Pessoa> value) {
    _empregados.value = value;
  }

  listarEmpregados() async {
    empregados = Get.find<AppController>().empregados;
    update();
  }


}

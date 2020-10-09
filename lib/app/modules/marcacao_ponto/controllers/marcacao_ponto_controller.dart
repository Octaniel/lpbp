import 'package:get/get.dart';
import 'package:lpbp/app/data/model/pessoa.dart';
import 'package:lpbp/app/data/repository/pessoa_repository.dart';

class MarcacaoPontoController extends GetxController {
  final pessoaRepository = PessoaRepository();

  final _image = "".obs;
  final _senha = "".obs;

  String get senha => _senha.value;

  set senha(value) {
    _senha.value = value;
  }

  String get image => _image.value;

  set image(String value) {
    _image.value = value;
    update();
  }
}

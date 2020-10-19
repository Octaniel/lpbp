import 'dart:io';

import 'package:get/get.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/data/repository/pessoa_repository.dart';
import 'package:lpbp/app/data/repository/presenca_repository.dart';

class MarcacaoPontoController extends GetxController {
  final pessoaRepository = PessoaRepository();
  final presencaRepository = PresencaRepository();

  final _presenca = Presenca().obs;


  Presenca get presenca => _presenca.value;

  set presenca(Presenca value) {
    _presenca.value = value;
  }

  final _image = "".obs;

  String get image => _image.value;

  set image(String value) {
    _image.value = value;
    update();
  }

  Future<bool> salvarPresenca() async {
   return await presencaRepository.salvar(presenca);
  }
}

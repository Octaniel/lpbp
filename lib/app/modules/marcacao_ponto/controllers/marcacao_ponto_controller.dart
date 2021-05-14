
import 'package:get/get.dart';
import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/data/repository/pessoa_repository.dart';
import 'package:lpbp/app/data/repository/presenca_repository.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../../app_controller.dart';

class MarcacaoPontoController extends GetxController {
  final pessoaRepository = PessoaRepository();
  final presencaRepository = PresencaRepository();

  final refres = "".obs;

  final _buttonState = ButtonState.idle.obs;

  get buttonState => _buttonState.value;

  set buttonState(ButtonState buttonStates) {
    _buttonState.value = buttonStates;
    refres.value = refres.value+"g";
    update(['buttonState']);
  }

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

  @override
  void onClose() {
    Get.find<AppController>().salvarTodos();
    super.onClose();
  }
}

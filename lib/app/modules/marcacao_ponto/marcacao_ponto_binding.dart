import 'package:get/get.dart';

import 'controllers/marcacao_ponto_controller.dart';

class MarcacaoPontoBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<MarcacaoPontoController>(MarcacaoPontoController());
  }

}
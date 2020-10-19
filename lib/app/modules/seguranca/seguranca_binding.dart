import 'package:get/get.dart';
import 'controllers/seguranca_controller.dart';

class SegurancaBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SegurancaController>(SegurancaController());
  }
}

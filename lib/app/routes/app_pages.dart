import 'package:lpbp/app/modules/home/home_binding.dart';
import 'package:lpbp/app/modules/home/pages/detalhe_empregado_page.dart';
import 'package:lpbp/app/modules/home/pages/lista_empregados_page.dart';
import 'package:lpbp/app/modules/marcacao_ponto/marcacao_ponto_binding.dart';
import 'package:lpbp/app/modules/marcacao_ponto/pages/marcacao_ponto_page.dart';

import 'app_routes.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.MARCAPONTO,
        page: () => MarcacaoPontoPage(),
        binding: MarcacaoPontoBinding()),
    GetPage(
        name: Routes.LISTAPRESENCA,
        page: () => ListaEmpregadosPage(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.DETALHEMPREGADO,
        page: () => DetalheEmpregadoPage(),
        binding: HomeBinding()),
  ];
}

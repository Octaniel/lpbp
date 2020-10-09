import 'package:get/get.dart';
import 'package:lpbp/app/data/model/pessoa.dart';
import 'package:lpbp/app/data/repository/pessoa_repository.dart';

class HomeController extends GetxController {
  final pessoaRepository = PessoaRepository();

  final _empregados = List<Pessoa>().obs;

  HomeController(){
    listarEmpregados();
  }

  List<Pessoa> get empregados => _empregados.value;

  set empregados(List<Pessoa> value) {
    _empregados.value = value;
  }

  listarEmpregados() async {
    empregados = await pessoaRepository.listar();
    update();
  }
}

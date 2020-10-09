import 'package:lpbp/app/data/model/pessoa.dart';
import 'package:lpbp/app/data/provider/pessoa_provider.dart';

class PessoaRepository{
  final pessoaProvider = PessoaProvider();

  Future<List<Pessoa>> listar() async {
    return await pessoaProvider.listar();
  }

  Future<bool> salvar(Pessoa pessoa)async{
    return await pessoaProvider.salvar(pessoa);
  }
}
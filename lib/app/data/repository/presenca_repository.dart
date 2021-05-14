import 'package:lpbp/app/data/model/presenca.dart';
import 'package:lpbp/app/data/model/presenca_resumo.dart';
import 'package:lpbp/app/data/provider/presenca_provider.dart';

class PresencaRepository{

  final presencaProvider = PresencaProvider();

  Future<bool> salvar(Presenca presenca) async {
    return await presencaProvider.salvar(presenca);
  }

  Future<bool> atualizar(Presenca presenca) async {
    return await presencaProvider.atualizar(presenca);
  }

  Future<List<PresencaResumo>> getPresencaResumo(String de, String ate) async {
    return await presencaProvider.getPresencaResumo(de, ate);
  }
}

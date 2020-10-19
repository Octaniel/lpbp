import 'package:lpbp/app/data/model/pessoa.dart';

class Usuario {
  int id;
  String nome;
  String senha;
  Pessoa pessoa;
  String grupo;

  Usuario({this.id, this.nome, this.senha, this.grupo});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    senha = json['senha'];
    pessoa = Pessoa.fromMap(json['pessoa']);
    grupo = json['grupo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['senha'] = this.senha;
    data['grupo'] = this.grupo;
    return data;
  }
}

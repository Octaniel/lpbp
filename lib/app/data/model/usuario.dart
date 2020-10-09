import 'package:lpbp/app/data/model/pessoa.dart';

class Usuario {
  int id;
  String nome;
  String senha;
  Pessoa pessoa;

  Usuario(
      {this.id,
      this.nome,
      this.senha});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    senha = json['senha'];
    pessoa = Pessoa.fromMap(json['pessoa']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['senha'] = this.senha;
    return data;
  }
}

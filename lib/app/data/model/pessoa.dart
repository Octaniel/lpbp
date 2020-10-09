import 'package:lpbp/app/data/model/presenca.dart';

class Pessoa {
  int id;
  String nome;
  String morada;
  String email;
  String telemovel;
  List<Presenca> presencas;

  Pessoa({
    this.id,
    this.nome,
    this.morada,
    this.email,
    this.telemovel,
    this.presencas,
  });

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    return new Pessoa(
      id: map['id'] as int,
      nome: map['nome'] as String,
      morada: map['morada'] as String,
      email: map['email'] as String,
      telemovel: map['telemovel'] as String,
      presencas: (map['presencas'] as List==null?List():map['presencas'] as List).map((e) => Presenca.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'nome': this.nome,
      'morada': this.morada,
      'email': this.email,
      'telemovel': this.telemovel,
    };
  }
}

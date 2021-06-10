import 'package:lpbp/app/data/model/presenca.dart';

class Pessoa {
  int id;
  String nome;
  String apelido;
  String morada;
  String email;
  String turno;
  String telemovel;
  String codigo;
  List<Presenca> presencas;

  Pessoa({
    this.id,
    this.nome,
    this.apelido,
    this.morada,
    this.email,
    this.turno,
    this.telemovel,
    this.presencas,
    this.codigo,
  });

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    return new Pessoa(
      id: map['id'] as int,
      nome: map['nome'] as String,
      apelido: map['apelido'] as String,
      morada: map['morada'] as String,
      email: map['email'] as String,
      turno: map['turno'] as String,
      telemovel: map['telemovel'] as String,
      presencas: (map['presencas'] as List==null?[]:map['presencas'] as List).map((e) => Presenca.fromJson(e)).toList(),
      codigo: map['codigo'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'nome': this.nome,
      'apelido': this.apelido,
      'morada': this.morada,
      'email': this.email,
      'turno': this.turno,
      'telemovel': this.telemovel,
      'codigo': this.codigo
    };
  }
}

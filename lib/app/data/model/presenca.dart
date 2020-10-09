

class Presenca {
  int id;
  DateTime dataCriacao;
  bool presente;

  Presenca({
    this.id,
    this.dataCriacao,
    this.presente,
  });

  factory Presenca.fromMap(Map<String, dynamic> map) {
    return new Presenca(
      id: map['id'] as int,
      dataCriacao: DateTime.parse(map['dataCriacao']),
      presente: map['presente'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'dataCriacao': this.dataCriacao,
      'presente': this.presente,
    };
  }
}

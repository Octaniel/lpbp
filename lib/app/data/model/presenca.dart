class Presenca {
  int id;
  DateTime dataCriacao;
  String nomeFoto;
  String nomeAudio;
  bool presente;
  bool justificada;
  bool justificacaoAceitoPorGerente;
  bool justificacaoAceitoPorAdministrador;
  String codigo;
  String gropo;

  Presenca(
      {this.id,
      this.dataCriacao,
      this.nomeFoto,
      this.nomeAudio,
      this.presente,
      this.justificada,
      this.justificacaoAceitoPorGerente,
      this.justificacaoAceitoPorAdministrador,
        this.codigo,});

  factory Presenca.fromMap(Map<String, dynamic> map) {
    return new Presenca(
      id: map['id'] as int,
      dataCriacao: DateTime.parse(map['dataCriacao']),
      nomeFoto: map['nomeFoto'] as String,
      nomeAudio: map['nomeAudio'] as String,
      presente: map['presente'] as bool,
      justificada: map['justificada'] as bool,
      justificacaoAceitoPorGerente: map['justificacaoAceitoPorGerente'] as bool,
      justificacaoAceitoPorAdministrador: map['justificacaoAceitoPorAdministrador'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    print(codigo);
    return {
      'id': this.id,
      'nomeFoto': this.nomeFoto,
      'nomeAudio': this.nomeAudio,
      'presente': this.presente,
      'justificada': this.justificada,
      'justificacaoAceitoPorGerente': this.justificacaoAceitoPorGerente,
      'justificacaoAceitoPorAdministrador': this.justificacaoAceitoPorAdministrador,
      'codigo': this.codigo,
    };
  }
}

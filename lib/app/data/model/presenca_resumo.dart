class PresencaResumo {
  String nome;
  int falta;
  int faltaJustificada;
  int faltaJustificadaAceitas;
  int presenca;

  PresencaResumo(
      {this.nome,
        this.falta,
        this.faltaJustificada,
        this.faltaJustificadaAceitas,
        this.presenca});

  PresencaResumo.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    falta = json['falta'];
    faltaJustificada = json['faltaJustificada'];
    faltaJustificadaAceitas = json['faltaJustificadaAceitas'];
    presenca = json['presenca'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['falta'] = this.falta;
    data['faltaJustificada'] = this.faltaJustificada;
    data['faltaJustificadaAceitas'] = this.faltaJustificadaAceitas;
    data['presenca'] = this.presenca;
    return data;
  }
}

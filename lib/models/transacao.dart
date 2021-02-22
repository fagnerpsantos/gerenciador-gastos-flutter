class Transacao {
  int id;
  String titulo, descricao, tipo;
  double valor;
  String data;
  int conta;

  Transacao({this.id, this.tipo, this.titulo, this.descricao,
    this.valor, this.data, this.conta});

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'titulo': titulo,
      'descricao': descricao,
      'valor': valor,
      'data': data,
      'conta_id': conta
    };
  }

  Transacao.fromJson(Map map){
    id = map["id"];
    titulo = map["titulo"];
    tipo = map["tipo"];
    descricao = map["descricao"];
    valor = map["valor"];
    data = map["data"];
    conta = map["conta"];
  }
}
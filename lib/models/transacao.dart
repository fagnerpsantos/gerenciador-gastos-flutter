class Transacao {
  int id, tipo;
  String titulo, descricao;
  double valor;
  String data;
  int conta;

  Transacao({this.id, this.tipo, this.titulo, this.descricao,
    this.valor, this.data, this.conta});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'titulo': titulo,
      'descricao': descricao,
      'valor': valor,
      'data': data,
      'conta': conta
    };
  }

  Transacao.fromMap(Map map){
    id = map["id"];
    titulo = map["titulo"];
    tipo = map["tipo"];
    descricao = map["descricao"];
    valor = map["valor"];
    data = map["data"];
    conta = map["conta"];
  }
}
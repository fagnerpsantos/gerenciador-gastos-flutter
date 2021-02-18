class Conta {
  int id;
  String titulo;
  double saldo;

  Conta({this.id, this.titulo, this.saldo});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'saldo': saldo,
    };
  }

  Map<String, dynamic> toJsonSaldo() {
    return {
      'saldo': saldo,
    };
  }

  Conta.fromJson(Map map){
    id = map["id"];
    titulo = map["titulo"];
    saldo = map["saldo"];
  }

}

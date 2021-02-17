class Conta {
  int id;
  String titulo;
  double saldo;

  Conta({this.id, this.titulo, this.saldo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'saldo': saldo,
    };
  }

  Map<String, dynamic> toMapSaldo() {
    return {
      'saldo': saldo,
    };
  }

  Conta.fromMap(Map map){
    id = map["id"];
    titulo = map["titulo"];
    saldo = map["saldo"];
  }

}

var conta = Conta(
    id: 1, titulo: "Minha carteira", saldo: 250.0
);

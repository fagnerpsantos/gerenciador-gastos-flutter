import 'package:flutter_apis_rest/models/transacao.dart';

class Conta {
  int id;
  String titulo;
  double saldo;
  // List<String, Map> transacoes;

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

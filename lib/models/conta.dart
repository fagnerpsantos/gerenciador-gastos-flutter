import 'package:flutter_apis_rest/models/transacao.dart';

class Conta {
  int id;
  String titulo;
  double saldo;
  List<Transacao> transacoes;

  Conta({this.id, this.titulo, this.saldo, this.transacoes});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'saldo': saldo,
      'transacoes': transacoes
    };
  }

  Map<String, dynamic> toJsonSaldo() {
    return {
      'saldo': saldo,
    };
  }

  Conta.fromJson(Map map){
    var list = map['transacoes'] as List;
    // print(list.runtimeType);
    List<Transacao> transacaoList = list.map((i) => Transacao.fromJson(i)).toList();
    // print(imagesList);
    id = map["id"];
    titulo = map["titulo"];
    saldo = map["saldo"];
    transacoes = transacaoList;
    // transacoes = (map["transacoes"] as List).map((e) => e).toList();
  }

}

import 'dart:convert';

import 'package:flutter_apis_rest/utils/http_util.dart';
import 'package:http/http.dart';
import '../models/transacao.dart';

class TransacaoRestService {
  Future<List<Transacao>> getTransacoes() async {
    final response = await HttpUtil.getData('http://10.0.2.2:5000/transacoes');
    if (response.statusCode == 200) {
      List<dynamic> conteudo = jsonDecode(response.body);
      List<Transacao> transacoes = conteudo.map((dynamic transacao) => Transacao.fromMap(
        transacao
      )).toList();
      return transacoes;
    } else {
      throw Exception('Erro ao listar transações');
    }
}

  Future<Transacao> addTransacao(Transacao transacao) async {
    final Response response = await post(
      'http://10.0.2.2:5000/transacoes',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(transacao.toMap()),
    );
    if (response.statusCode == 200) {
      return Transacao.fromMap(json.decode(response.body));
    } else {
      throw Exception('Erro ao cadastrar transação');
    }
  }

}
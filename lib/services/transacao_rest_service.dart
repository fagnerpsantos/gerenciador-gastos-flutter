import 'dart:convert';

import 'package:flutter_apis_rest/utils/http_util.dart';
import 'package:http/http.dart';
import '../models/transacao.dart';

class TransacaoRestService {
  Future<List<Transacao>> getTransacoes() async {
    final response = await HttpUtil.getData('http://10.0.2.2:5000/transacoes');
    if (response.statusCode == 200) {
      List<dynamic> conteudo = jsonDecode(response.body);
      List<Transacao> transacoes = conteudo.map((dynamic transacao) => Transacao.fromJson(
        transacao
      )).toList();
      return transacoes;
    } else {
      throw Exception('Erro ao listar transações');
    }
}

  Future<Transacao> addTransacao(Transacao transacao) async {
    // final novaTransacao = {
    //   'titulo': transacao.titulo,
    //   'tipo': transacao.tipo,
    //   'descricao': transacao.descricao,
    //   'valor': transacao.valor,
    //   'data': transacao.data,
    //   'conta_id': transacao.conta
    // };
    final Response response = await post(
      'http://10.0.2.2:5000/transacoes',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(transacao.toJson()),
    );
    if (response.statusCode == 201) {
      return Transacao.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao cadastrar transação');
    }
  }

  Future<Transacao> getTransacaoId(String id) async {
    final response = await get('http://10.0.2.2:5000/transacoes/$id');
    if (response.statusCode == 200) {
      return Transacao.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao buscar conta');
    }
  }

  Future<void> removeTransacao(String id) async {
    final response = await delete('http://10.0.2.2:5000/transacoes/$id');
    if (response.statusCode == 204) {
      print("conta removida");
    } else {
      throw Exception('Falha ao remover conta');
    }
  }

  Future<Transacao> editTransacao(Transacao transacao, String id) async {
    final novaTransacao = {
      'titulo': transacao.titulo,
      'tipo': transacao.tipo == "TipoEnum.entrada" ? "1" : "2" ,
      'descricao': transacao.descricao,
      'valor': transacao.valor,
      'data': transacao.data,
      'conta_id': transacao.conta
    };

    final Response response = await put(
      'http://10.0.2.2:5000/transacoes/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(novaTransacao),
    );
    if (response.statusCode == 200) {
      return Transacao.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao editar transação');
    }
  }

}
import 'dart:convert';

import 'package:flutter_apis_rest/utils/http_util.dart';
import 'package:http/http.dart';
import '../models/transacao.dart';
import 'package:asuka/asuka.dart' as asuka;


class TransacaoRestService {
  Future<List<Transacao>> getTransacoes() async {
    final response = await HttpUtil.getData('transacoes');
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
    final Response response = await HttpUtil.addData('transacoes', transacao.toJson());
    if (response.statusCode == 201) {
      return Transacao.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao cadastrar transação');
    }
  }

  Future<Transacao> getTransacaoId(String id) async {
    final response = await HttpUtil.getDataId('transacoes', id);
    if (response.statusCode == 200) {
      return Transacao.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao buscar conta');
    }
  }

  Future<void> removeTransacao(String id) async {
    final response = await HttpUtil.removeData('transacoes', id);
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

    final Response response = await HttpUtil.editData('transacoes', novaTransacao, id);
    if (response.statusCode == 200) {
      return Transacao.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao editar transação');
    }
  }

}
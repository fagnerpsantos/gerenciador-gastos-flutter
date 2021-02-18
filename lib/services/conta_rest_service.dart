import 'dart:convert';

import 'package:flutter_apis_rest/utils/http_util.dart';
import 'package:http/http.dart';
import '../models/conta.dart';

class ContaRestService {
  Future<List<Conta>> getContas() async {
    final response = await HttpUtil.getData('http://10.0.2.2:5000/contas');
    if (response.statusCode == 200) {
      List<dynamic> conteudo = jsonDecode(response.body);
      List<Conta> contas = conteudo.map((dynamic conta) => Conta.fromMap(
          conta
      )).toList();
      return contas;
    } else {
      throw Exception('Erro ao listar contas');
    }
  }

  Future<Conta> getContaId(String id) async {
    final response = await get('http://10.0.2.2:5000/contas/$id');
    if (response.statusCode == 200) {
      return Conta.fromMap(json.decode(response.body));
    } else {
      throw Exception('Falha ao buscar conta');
    }
  }

  Future<Conta> addConta(Conta conta) async {
    final Response response = await post(
      'http://10.0.2.2:5000/contas',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(conta.toMap()),
    );
    if (response.statusCode == 201) {
      return Conta.fromMap(json.decode(response.body));
    } else {
      throw Exception('Falha ao cadastrar conta');
    }
  }

}
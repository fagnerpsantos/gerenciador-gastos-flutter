import 'dart:convert';
import 'package:http/http.dart';
import '../models/conta.dart';
import '../utils/http_util.dart';


class ContaRestService {
  Future<List<Conta>> getContas() async {
    final response = await HttpUtil.getData('contas');
    if (response.statusCode == 401) {
      throw Exception('Erro de autenticação');

    }
    else if (response.statusCode == 200) {
      List<dynamic> conteudo = jsonDecode(response.body);
      List<Conta> contas = conteudo.map((dynamic conta) => Conta.fromJson(
          conta
      )).toList();
      return contas;
    } else {
      throw Exception('Erro ao listar contas');
    }
  }

  Future<Conta> getContaId(String id) async {
    final response = await HttpUtil.getDataId('contas', id);
    if (response.statusCode == 200) {
      print(response.body);
      return Conta.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao buscar conta');
    }
  }

  Future<void> removeConta(String id) async {
    final response = await HttpUtil.removeData('contas', id);
    if (response.statusCode == 204) {
      print("conta removida");
    } else {
      throw Exception('Falha ao remover conta');
    }
  }

  Future<Conta> addConta(Conta conta) async {
    final novaConta =  {
      'titulo': conta.titulo,
      'saldo': conta.saldo,
    };
    final Response response = await HttpUtil.addData('contas', novaConta);
    if (response.statusCode == 201) {
      return Conta.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao cadastrar conta');
    }
  }

}
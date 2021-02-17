import '../models/conta.dart';
import '../utils/db_util.dart';

class ContaService {
  List<Conta> _contaList = [];

  Future<List> getAllContas() async {
    final dataList = await DbUtil.getData('conta');
    _contaList = dataList.map((contas) => Conta(
        id: contas['id'],
        titulo: contas['titulo'],
        saldo: contas['saldo'],
    )).toList();
    return _contaList;
  }

  void addConta(Conta conta){
    final newConta = Conta(
      titulo: conta.titulo,
      saldo: conta.saldo,
    );
    DbUtil.insertData('conta', newConta.toMap());
  }

  void editConta(int id, Conta conta) async {
    final newConta = Conta(
      id: id,
      titulo: conta.titulo,
      saldo: conta.saldo,
    );
    String whereString = "id = ?";
    int rowId = id;
    List<dynamic> whereArguments = [rowId];
    DbUtil.editData("conta", newConta.toMap(), whereString, whereArguments);
  }

  void editSaldoConta(int id, double valor, int tipoTransacao) {
    String sql;
    if (tipoTransacao == 1) {
      sql = 'UPDATE conta SET saldo = saldo + ? WHERE id = ?';
    } else {
      sql = 'UPDATE conta SET saldo = saldo - ? WHERE id = ?';
    }
    List<dynamic> arguments = [valor, id];
    DbUtil.executeSQL(sql, arguments);

  }

  Future<Conta> getConta(int id) async {
    List<String> columnsToSelect = [
      "id",
      "titulo",
      "saldo"
    ];
    String whereString = "id = ?";
    int rowId = id;
    List<dynamic> whereArguments = [rowId];
    final dataList = await DbUtil.getDataId("conta", columnsToSelect, whereString, whereArguments);
    return Conta.fromMap(dataList.first);
  }
}
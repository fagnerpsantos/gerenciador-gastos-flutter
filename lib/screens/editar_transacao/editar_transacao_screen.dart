import 'package:flutter/material.dart';
import 'package:flutter_apis_rest/services/conta_rest_service.dart';
import 'package:flutter_apis_rest/services/transacao_rest_service.dart';
import '../../models/conta.dart';
import '../../models/transacao.dart';
import '../../screens/constants/color_contant.dart';
import '../../screens/home/home_screen.dart';
import '../../services/conta_service.dart';
import '../../services/transacao_service.dart';
import 'package:date_format/date_format.dart';



class EditarTransacaoScreen extends StatefulWidget {
  final String idTransacao;

  EditarTransacaoScreen({this.idTransacao});

  @override
  _EditarTransacaoScreenState createState() => _EditarTransacaoScreenState();
}

class _EditarTransacaoScreenState extends State<EditarTransacaoScreen> {
  Transacao transacao;
  ContaRestService crs = ContaRestService();
  TransacaoRestService trs = TransacaoRestService();
  Future<List> _loadContas;
  Transacao _transacao;
  Future<Transacao> _loadTransacao;
  List<Conta> _contas;
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  final _dataController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Conta _contaSelecionada;


  @override
  void initState() {
    super.initState();
    _loadTransacao = _getTransacao(widget.idTransacao);
    _loadContas = _getContas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar de transação"),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
          future: _loadTransacao,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              _transacao = snapshot.data;
              _tituloController.text = _transacao.titulo;
              _descricaoController.text = _transacao.descricao;
              _valorController.text = _transacao.valor.toString();
              _dataController.text = _transacao.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _tituloController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: "Título"),
                          onChanged: (String value) {
                            _transacao.titulo = value;
                          },
                        ),
                        TextFormField(
                          // controller: _descricaoController,
                          keyboardType: TextInputType.text,
                          initialValue: _transacao.descricao,
                          decoration: InputDecoration(labelText: "Descrição"),
                          onChanged: (String value) {
                            _transacao.descricao = value;
                          },
                        ),
                        TextFormField(
                          // controller: _valorController,
                          keyboardType: TextInputType.text,
                          initialValue: _transacao.valor.toString(),
                          decoration: InputDecoration(labelText: "Valor"),
                          onChanged: (String value) {
                            _transacao.valor = double.parse(value);
                          },
                        ),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              // controller: _dataController,
                              keyboardType: TextInputType.datetime,
                              initialValue: _transacao.data,
                              decoration:
                              InputDecoration(
                                  labelText: formatDate(
                                      selectedDate, [dd, '/', mm, '/', yyyy])),
                            ),
                          ),
                        ),
                        FutureBuilder(
                        future: _loadContas,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            _contas = snapshot.data;
                            return DropdownButtonFormField(
                              value: _contaSelecionada,
                              onChanged: (Conta conta) {
                                setState(() {
                                  _contaSelecionada = conta;
                                });
                              },
                              items: _contas.map((e) {
                                return DropdownMenuItem<Conta>(
                                  value: e, child: Text(e.titulo),
                                );
                              }).toList(),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () {
                                // print(_transacao.titulo);
                                Transacao newTransacao = Transacao(
                                    titulo: _transacao.titulo,
                                    descricao: _transacao.descricao,
                                    tipo: _transacao.tipo,
                                    valor: double.parse(_transacao.valor.toString()),
                                    data: formatDate(
                                        selectedDate, [yyyy, '-', mm, '-', dd]).toString(),
                                    conta: _contaSelecionada.id);
                                trs.editTransacao(newTransacao, _transacao.id.toString());
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => HomeScreen(),
                                  ),
                                );
                              },
                              color: Colors.blueAccent,
                              child: Text(
                                "Editar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<List> _getContas() async {
    return await crs.getContas();
  }

  Future<Transacao> _getTransacao(String id) async {
    return await trs.getTransacaoId(id);
  }

}


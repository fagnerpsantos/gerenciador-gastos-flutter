import 'package:flutter/material.dart';
import 'package:flutter_apis_rest/services/conta_rest_service.dart';
import '../../models/conta.dart';
import '../../models/transacao.dart';
import '../../screens/constants/color_contant.dart';
import '../../screens/home/home_screen.dart';
import '../../services/conta_service.dart';
import '../../services/transacao_service.dart';
import 'package:date_format/date_format.dart';



class CadastrarTransacaoScreen extends StatefulWidget {
  final int tipoTransacao;

  CadastrarTransacaoScreen({this.tipoTransacao});

  @override
  _CadastrarTransacaoScreenState createState() => _CadastrarTransacaoScreenState();
}

class _CadastrarTransacaoScreenState extends State<CadastrarTransacaoScreen> {
  TransacaoService ts = TransacaoService();
  Transacao transacao;
  ContaService cs = ContaService();
  ContaRestService crs = ContaRestService();
  Future<List> _loadContas;
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
    _loadContas = _getContas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de transação"),
        backgroundColor: widget.tipoTransacao == 1 ? kGreenColor : Colors.redAccent,
      ),
      body: FutureBuilder(
        future: _loadContas,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _contas = snapshot.data;
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
                      ),
                      TextFormField(
                        controller: _descricaoController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Descrição"),
                      ),
                      TextFormField(
                        controller: _valorController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Valor"),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _dataController,
                            keyboardType: TextInputType.datetime,
                            decoration:
                            InputDecoration(
                                labelText: formatDate(
                                    selectedDate, [dd, '/', mm, '/', yyyy])),
                          ),
                        ),
                      ),
                      DropdownButtonFormField(
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              Transacao newTransacao = Transacao(
                                  titulo: _tituloController.text,
                                  descricao: _descricaoController.text,
                                  tipo: widget.tipoTransacao,
                                  valor: double.parse(_valorController.text),
                                  data: selectedDate.toString(),
                                  conta: _contaSelecionada.id);
                              ts.addTransacao(newTransacao);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => HomeScreen(),
                                ),
                              );
                            },
                            color: widget.tipoTransacao == 1 ? kGreenColor : Colors.redAccent,
                            child: Text(
                              "Cadastrar",
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

}


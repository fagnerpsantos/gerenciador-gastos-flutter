import 'package:flutter/material.dart';
import '../../models/conta.dart';
import '../../screens/constants/color_contant.dart';
import '../../screens/home/home_screen.dart';
import '../../services/conta_service.dart';
import 'package:date_format/date_format.dart';



class CadastrarContaScreen extends StatefulWidget {
  @override
  _CadastrarContaScreenState createState() => _CadastrarContaScreenState();
}

class _CadastrarContaScreenState extends State<CadastrarContaScreen> {
  final ContaService ts = ContaService();
  Conta conta;
  final _tituloController = TextEditingController();
  final _saldoController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de conta"),
        backgroundColor: kBlueColor,
      ),
      body: SingleChildScrollView(
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
                  controller: _saldoController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Saldo"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        Conta newConta = Conta(
                            titulo: _tituloController.text,
                            saldo: double.parse(_saldoController.text));
                        ts.addConta(newConta);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(),
                          ),
                        );
                      },
                      color: kBlueColor,
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
      ),
    );
  }
}


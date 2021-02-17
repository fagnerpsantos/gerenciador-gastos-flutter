import 'package:flutter/material.dart';
import '../../screens/conta/components/body.dart';

class ContaScreen extends StatefulWidget {
  final int idConta;

  ContaScreen({this.idConta});

  @override
  _ContaScreenState createState() => _ContaScreenState();
}

class _ContaScreenState extends State<ContaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(idConta: widget.idConta,),
    );
  }
}

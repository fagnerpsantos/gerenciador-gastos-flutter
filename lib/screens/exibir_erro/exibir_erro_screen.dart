import 'package:flutter/material.dart';

class ExibirErroScreen extends StatelessWidget {
  final String erro;

  ExibirErroScreen({this.erro});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          this.erro
        ),
      ),
    );
  }
}

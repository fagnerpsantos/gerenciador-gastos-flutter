import 'package:flutter/material.dart';
import '../../screens/transacao/components/body.dart';

class TransacaoScreen extends StatefulWidget {
  @override
  _TransacaoScreenState createState() => _TransacaoScreenState();
}

class _TransacaoScreenState extends State<TransacaoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),

      ),
      body: Body(),
    );
  }
}

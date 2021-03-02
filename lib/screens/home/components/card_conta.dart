import 'package:flutter/material.dart';
import 'package:flutter_apis_rest/services/conta_rest_service.dart';
import 'package:flutter_apis_rest/services/transacao_rest_service.dart';
import '../../../models/conta.dart';
import '../../../screens/constants/color_contant.dart';
import '../../../screens/conta/conta_screen.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cardConta(BuildContext context, Conta conta) {

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ContaScreen(idConta: conta.id,),
          ),
        );
      },
      onLongPress: () {
        showAlertDialog(context, conta);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10, left: 10),
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kBlueColor,
          boxShadow: [
            BoxShadow(
                color: Color(0x10000000),
                blurRadius: 10,
                spreadRadius: 4,
                offset: Offset(0.0, 8.0))
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 14,
              right: 12,
              child: Text(
                conta.titulo,
                style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            Positioned(
              top: 63,
              left: 16,
              child: Text(
                'Saldo em conta',
                style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
            Positioned(
              left: 16,
              top: 81,
              child: Text(
                'R\$ ' + conta.saldo.toString(),
                style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

showAlertDialog(BuildContext context, Conta conta)
{
  ContaRestService crs = ContaRestService();
  // configura o button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      crs.removeConta(conta.id.toString());
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text("Deseja remover a conta?"),
    content: Text("Esta ação não pode ser desfeita."),
    actions: [
      okButton,
      cancelaButton
    ],
  );
  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}



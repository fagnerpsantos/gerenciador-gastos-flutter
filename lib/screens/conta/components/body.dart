import 'package:flutter/material.dart';
import 'package:flutter_apis_rest/services/conta_rest_service.dart';
import 'package:flutter_apis_rest/services/transacao_rest_service.dart';
import '../../../models/conta.dart';
import '../../../models/transacao.dart';
import '../../../screens/components/card_transacao.dart';
import '../../../screens/constants/color_contant.dart';
import '../../../screens/home/components/card_conta.dart';
import '../../../screens/transacao/transacao_screen.dart';
import '../../../services/conta_service.dart';
import '../../../services/transacao_service.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  final int idConta;
  Body({this.idConta});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ContaRestService crs = ContaRestService();
  TransacaoRestService trs = TransacaoRestService();
  Future<Conta> _loadConta;
  Conta _conta;

  @override
  void initState() {
    // TODO: implement initState
    _loadConta = _getConta(widget.idConta);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadConta,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _conta = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                EdgeInsets.only(top: 67, bottom: 16),

                child: Container(
                    height: 175,
                    width: double.infinity,
                    child: cardConta(context, _conta)
                ),
              ),
              Padding(
                  padding:
                  EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Transações',
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: kBlackColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TransacaoScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'ver todas',
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: kBlueColor,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _conta.transacoes.length,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return cardTransacao(
                        context, index, _conta.transacoes[index]);
                  },
                ),
              )
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  Future<Conta> _getConta(int id) async {
    return await crs.getContaId(id.toString());
  }
}

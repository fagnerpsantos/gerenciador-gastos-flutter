import 'package:flutter/material.dart';
import 'package:flutter_apis_rest/services/conta_rest_service.dart';
import 'package:flutter_apis_rest/services/transacao_rest_service.dart';
import '../../../models/conta.dart';
import '../../../models/transacao.dart';
import '../../../screens/components/card_transacao.dart';
import '../../../screens/constants/color_contant.dart';
import '../../../screens/transacao/transacao_screen.dart';
import '../../../services/conta_service.dart';
import '../../../services/transacao_service.dart';
import 'package:google_fonts/google_fonts.dart';

import 'card_conta.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  ContaRestService crs = ContaRestService();
  TransacaoRestService trs = TransacaoRestService();
  Future<List> _loadTransacoes;
  Future<List> _loadContas;
  List<Transacao> _transacoes;
  List<Conta> _contas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Padding(
        padding:
        EdgeInsets.only(top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 175,
                child: FutureBuilder(
                    future: _loadContas,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        _contas = snapshot.data;
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _contas.length,
                            padding: EdgeInsets.only(left: 16, right: 8),
                            itemBuilder: (context, index) {
                              return cardConta(context, _contas[index]);
                            },
                          );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                ),
              ),
              Padding(
                  padding:
                  EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Últimas transações',
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
              FutureBuilder(
                future: _loadTransacoes,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    _transacoes = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                        // physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _transacoes.length > 6 ? 6 : _transacoes.length,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          return cardTransacao(context, index, _transacoes[index]);
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              ),
            ],
          ),
      ),
      onRefresh: _refresh,
    );

  }

  Future<Null> _refresh() async {
    refreshKey.currentState?.show(atTop: false);
    // await Future.delayed(Duration(seconds: 2));
    setState(() {
      _loadTransacoes = _getTransacoes();
      _loadContas = _getContas();
    });
  }

  Future<List> _getTransacoes() async {
    return await trs.getTransacoes();
  }

  Future<List> _getContas() async {
    return await crs.getContas();
  }
}

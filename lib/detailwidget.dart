import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'editdatawidget.dart';
import 'models/cases.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget(this.cases);

  final Cases cases;

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  _DetailWidgetState();

  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do produto'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Card(
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 440,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Nome do solicitante:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.cases.name,
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      /*Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Gender:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.cases.gender,
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),*/
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('RG:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.cases.age.toString(),
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Descri????o do item:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.cases.address,
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('S/N ou identifica????o:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.cases.city,
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Cidade:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.cases.country,
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Tamanho do item:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.cases.status,
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Data de atualiza????o:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                                widget.cases.updated != null
                                    ? widget.cases.updated
                                    : '',
                                style: Theme.of(context).textTheme.headline6)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                _navigateToEditScreen(context, widget.cases);
                              },
                              child: Text('Edit',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _confirmDialog();
                              },
                              child: Text('Delete',
                                  style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }

  _navigateToEditScreen(BuildContext context, Cases cases) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDataWidget(cases)),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                api.deleteCase(widget.cases.id);
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

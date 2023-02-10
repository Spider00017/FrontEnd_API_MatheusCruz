import 'package:flutter/material.dart';
import 'dart:async';

import 'adddatawidget.dart';
import 'caseslist.dart';
import 'models/cases.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guarda Volumes',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'GUARDA VOLUMES'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService api = ApiService();
  List<Cases> casesList = [];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text("Guarda Volumes "),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      ),
      body: RefreshIndicator(
        onRefresh: _getData,
        child: Container(
          child: Center(
              child: FutureBuilder<List<Cases>>(
            future: loadList(),
            builder: (context, AsyncSnapshot<List<Cases>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print("feature builder");
              print(snapshot.connectionState);
              return casesList.length > 0
                  ? CasesList(cases: casesList)
                  : Center(
                      child: Text('No data found, tap plus button to add!',
                          style: Theme.of(context).textTheme.headline6));
            },
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<Cases>> loadList() async {
    print("load list");
    Future<List<Cases>> futureCases = api.getCases();
    futureCases.then((casesList) {
      print("setState");
      //setState(() {
      this.casesList = casesList;
      //});
    });
    return futureCases;
  }

  Future<void> _getData() async {
    setState(() {
      loadList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadList();
  }

  _navigateToAddScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataWidget()),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomSheet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DetailBottomSheet(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DetailBottomSheet extends StatefulWidget {
  @override
  _DetailBottomSheetState createState() => _DetailBottomSheetState();
}

class _DetailBottomSheetState extends State<DetailBottomSheet>{
  final _scaffoldKey =new GlobalKey<ScaffoldState>();

  void _showModalSheet(){
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return new Container(
            height: 200.0,
            color: Colors.black12,
            child: new Center(
              child: new Text(" Modal BottomSheet",textScaleFactor: 2,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key:_scaffoldKey,
      appBar: new AppBar(
        title: new Text("Bottomsheet"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          Text("GFG",textScaleFactor: 2,)
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(top: 10.0),
            ),
            new RaisedButton(
              color: Colors.red,
              onPressed: _showModalSheet,
              child: new Text("Model",
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[100],
    );
  }
}

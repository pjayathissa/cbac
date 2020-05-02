import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';

import 'authentication.dart';
import 'scan.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Clinician side CBAC App"),
        actions: <Widget>[
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: signOut)
          ],
      ),
      body: new Container(
        child: ListView(
            shrinkWrap: true,
            children: <Widget>[
            Text("Hello ${widget.userId}"),
            showButtons(),
            ]
        ),
      ),
    );
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  Widget showButtons() {
    return Center(
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          splashColor: Colors.blueGrey,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScanScreen()),
                            );
                          },
                          child: const Text('Scan QR Code')
                      ),
                    ),
                   Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          splashColor: Colors.blueGrey,
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => GenerateScreen()),
                            // );
                          },
                          child: const Text('Enter Manually')
                      ),
                    ),
                ],
              )
          );
  }



}
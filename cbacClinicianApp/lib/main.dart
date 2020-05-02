import 'package:flutter/material.dart';

import 'root_page.dart';
import 'authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinician Side App',
      theme: ThemeData(
        //primarySwatch: Color(0xff15c3a5),
        primaryColor: Color(0xff15c3a5),
      ),
      // Root page decides whether to show the user the home or LoginPage
      home: new RootPage(auth: new Auth())
    );
  }
}
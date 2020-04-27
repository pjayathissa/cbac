
import 'package:flutter/material.dart';

import 'user.dart';

class GenerateScreen extends StatelessWidget {
  // note quite sure how this worked but it did
  final User user;

  GenerateScreen({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Details"),
      ),
      body: ListView(
          children: <Widget>[

          Container(
            padding: const EdgeInsets.all(32),
            child: Text(
              "First Name is: " + user.firstName,
            ),
          ),

          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ]
      ),
    );
  }
}


// class User {
//   // static const String Cough = 'cough';
//   // static const String Fever = 'fever';

//   String firstName = 'placeholder';
//   String lastName = 'placeholder';
//   Map symptoms = {
//     "cough": false,
//     "fever": false,
//   };
//   bool newsletter = false;
//   save() {
//     print('saving user using a web service');
//   }
// }
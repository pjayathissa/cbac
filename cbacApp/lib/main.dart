import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart';

import 'user.dart';
import 'output.dart';


// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      //padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Community Based Assessment Center',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'North Shore, Auckland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('Waiting: 41'),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );

    return MaterialApp(
      title: 'CBAC Demo App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('CBAC Demo App'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          children: [
            // Image.asset(
            //   'assets/heart.png',
            //   width: 600,
            //   height: 240,
            //   //fit: BoxFit.cover,
            // ),
            titleSection,
            //buttonSection,
            MyCustomForm(),
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
  // I think this could also be written as: MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _user = User();

  //controller for controlling the output
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  // Function to print latest form value
  printLatestValue() {
  print("First Name text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    Widget myTextSection = Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(

        'Please fill out this form as accurately as possible while waiting  '
            'for your turn in the queue. Once complete, push submit ',
        softWrap: true,
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[

          myTextSection,
          CustomTextInput(user: _user, 
                          detailAttribute: 'firstName',
                          myHintText: "Enter your first name", 
                          myLabelText: "First Name",
                          ),
          CustomTextInput(user: _user, 
                          detailAttribute: 'lastName',
                          myHintText: "Enter your last name", 
                          myLabelText: "Last Name",
                          ),
          CustomTextInput(user: _user, 
                          detailAttribute: 'street',
                          myHintText: "17 Example Street", 
                          myLabelText: "Street",
                          ),
          CustomTextInput(user: _user, 
                          detailAttribute: 'city',
                          myHintText: "Auckland", 
                          myLabelText: "Town / City",
                          ),
          CustomTextInput(user: _user, 
                          detailAttribute: 'postCode',
                          myHintText: "0000", 
                          myLabelText: "Post Code",
                          ),


          Container(
            padding: const EdgeInsets.all(32),
            child: Text(
              'Symptoms',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Flexible(
              child: CheckboxListTile(
                title: const Text('Cough'),
                value: _user.symptoms["cough"],
                onChanged: (val) {
                  setState(() =>
                      _user.symptoms["cough"] = val);
                }
                ),
              ),
              Flexible(
                child: CheckboxListTile(
                  title: const Text('Fever'),
                  value: _user.symptoms["fever"],
                  onChanged: (val) {
                    setState(() =>
                        _user.symptoms["fever"] = val);
                  }
                ),
              ),
              Flexible(
                child: CheckboxListTile(
                  title: const Text('Fever'),
                  value: _user.symptoms["fever"],
                  onChanged: (val) {
                    setState(() =>
                        _user.symptoms["fever"] = val);
                  }
                ),
              ),
            ]
          ),

          CheckboxListTile(
            title: const Text('TODO: Add more checkboxes'),
            value: _user.symptoms["other"],
            onChanged: (val) {
              setState(() =>
                  _user.symptoms["other"] = val);
            }
          ),


          RaisedButton(
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.
              if (_formKey.currentState.validate()) {
                print(_user.lastName);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateScreen(user: _user)),
                );
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.

                // Scaffold
                //     .of(context)
                //     .showSnackBar(SnackBar(content: Text("Submitted: " + myController.text)));
              }
            },
            child: Text('Submit'),
          ),
        ]
     )
    );
  }
}



class CustomTextInput extends StatefulWidget {
  
  CustomTextInput({Key key, 
                    @required this.detailAttribute,
                    @required this.user, 
                    @required this.myHintText, 
                    @required this.myLabelText}) : super(key: key);
  final User user;
  final myHintText;
  final myLabelText;
  final detailAttribute;

  @override
  _CustomTextInputState createState() => _CustomTextInputState(user, myHintText, myLabelText, detailAttribute);
}

class _CustomTextInputState extends State<CustomTextInput> {
  
  // final myLabelText;
  final User user;
  final String myHintText;
  final String myLabelText;
  final String detailAttribute;
  _CustomTextInputState(this.user, this.myHintText, this.myLabelText, this.detailAttribute);

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
              hintText: myHintText,
              labelText: myLabelText,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) => setState(() => user.userDetails[detailAttribute] = value),
    ),
    );
  }
}

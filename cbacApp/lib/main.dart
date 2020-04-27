import 'package:flutter/material.dart';

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
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
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
          Text('41'),
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

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Please fill out this form as accurately as possible while waiting  '
            'for your turn in the que. Once complete, push submit ',
        softWrap: true,
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
            Image.asset(
              'assets/lake.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
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

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[

          TextFormField(
            controller: myController,
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your first name',
              labelText: 'First Name',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) => setState(() => _user.firstName = value),
          ),

          TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your last name',
              labelText: 'Last Name',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) => setState(() => _user.lastName = value),
          ),

          Container(
            padding: const EdgeInsets.all(32),
            child: Text(
              'Symptoms',
            ),
          ),

          CheckboxListTile(
            title: const Text('Cough'),
            value: _user.symptoms["cough"],
            onChanged: (val) {
              setState(() =>
                  _user.symptoms["cough"] = val);
            }
          ),
          CheckboxListTile(
            title: const Text('Fever'),
            value: _user.symptoms["fever"],
            onChanged: (val) {
              setState(() =>
                  _user.symptoms["fever"] = val);
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

                Scaffold
                    .of(context)
                    .showSnackBar(SnackBar(content: Text("Submitted: " + myController.text)));
              }
            },
            child: Text('Submit'),
          ),
        ]
     )
    );
  }
}


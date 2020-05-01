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
      theme: ThemeData(
        // Define the default brightness and colors.
        // brightness: Brightness.dark,
        primaryColor: Color(0xff15c3a5),
        // accentColor: Colors.cyan[600],
        primaryTextTheme: TextTheme(
          title: TextStyle(
            color: Colors.white
          )
        )

        // Define the default font family.
        //fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        // textTheme: TextTheme(
        //   headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // ),
      ),
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

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(new Duration(days: 15)),
          lastDate: DateTime.now());
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          _user.travelDate = picked;
        });
    }

  Widget checkbox(String title, String key) {
    return Flexible(
                  child: Ink(
                    decoration: BoxDecoration(
                      color: _user.symptoms[key] ? Color(0xff15c3a5) : Color(0xfff8f8f8),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                // boxShadow: [
                                  // BoxShadow(

                                  //     color: Color(0xffA22447).withOpacity(.05),
                                  //     offset: Offset(1, 1),
                                  //     blurRadius: 2,
                                  //     spreadRadius: 1
                                  // )]
                            ),
                    
                    child: CheckboxListTile(

                    title: Text(
                      title,
                      style: DefaultTextStyle.of(context).style.apply(
                        fontSizeFactor: 1.0,
                        color: _user.symptoms[key] ? Colors.white : Colors.black,
                        ),
                      ),
                    activeColor: Color(0xffBEEDE4),
                    value: _user.symptoms[key],
                    onChanged: (val) {
                      setState(() =>
                          _user.symptoms[key] = val);
                    }
                  ),
                ),
              );
}

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
  print('First Name text field: ${myController.text}');
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
                          myHintText: 'Enter your first name', 
                          myLabelText: 'First Name',
                          ),
          CustomTextInput(user: _user, 
                          detailAttribute: 'lastName',
                          myHintText: 'Enter your last name', 
                          myLabelText: 'Last Name',
                          ),
          CustomTextInput(user: _user, 
                          detailAttribute: 'street',
                          myHintText: '17 Example Street', 
                          myLabelText: 'Street',
                          ),
          CustomTextInput(user: _user, 
                          detailAttribute: 'city',
                          myHintText: 'Auckland', 
                          myLabelText: 'Town / City',
                          ),
          CustomTextInput(user: _user, 
                          detailAttribute: 'postCode',
                          myHintText: '0000', 
                          myLabelText: 'Post Code',
                          ),
          CustomTextInput(user: _user, 
                          detailAttribute: 'email',
                          myHintText: 'example@gmail.com', 
                          myLabelText: 'Email Address',
                          ),
          CustomTextInput(user: _user, 
                          detailAttribute: 'phoneNumber',
                          myHintText: 'home, mobile, or relative\'s', 
                          myLabelText: 'Phone Number',
                          ),


          Container(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'Symptoms',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            checkbox('Cough','cough'),
            checkbox('Fever','fever'),


            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            checkbox('Sore Throat','soreThroat'),
            checkbox('Runny Nose','coryza'),


            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            checkbox('Shortness of Breath','breath'),
            checkbox('Loss of smell','anosmia'),
            

            ]
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //   checkbox('Other','other'),
          //   ]
          // ),
          Container(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'Other Symnptoms',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            checkbox('Diarrhoea','diarrhoea'),
            checkbox('Headache','headache'),
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            checkbox('Muscle Pain','myalgia'),
            checkbox('Confusion','confusion'),
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            checkbox('Nausea','nausea'),
            ]
          ),
          Container(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'Have you travelled overseas or been in contact with someone who was overseas in the past 14 days',
            ),
          ),

          Column(
                children: _user.travelOptions.map((travelValue) => Ink(
                    color: _user.travelValue == travelValue['key'] ? Color(0xff15c3a5) : Color(0xfff8f8f8),
                    child: RadioListTile(
                    groupValue: _user.travelValue,
                    title: Text(
                      travelValue['title'],
                      style: DefaultTextStyle.of(context).style.apply(
                        fontSizeFactor: 1.0,
                        color: _user.travelValue == travelValue['key'] ? Colors.white : Colors.black,
                        )),
                    value: travelValue['key'],
                    activeColor: Color(0xffBEEDE4),
                    onChanged: (val) {
                        setState(() {
                            debugPrint('VAL = $val');
                            _user.travelValue = val;
                            if (val == 'yes') {
                              _selectDate(context);
                            }
                        });
                    },
                ))).toList(),
          ),
          if (_user.travelValue == 'yes') Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Arrival / Contact Date:  ${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}  "),
            SizedBox(height: 20.0,),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text('Change date'),
            ),
          ],
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
                //     .showSnackBar(SnackBar(content: Text('Submitted: ' + myController.text)));
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
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Please enter some text';
            //   }
            //   return null;
            // },
            onChanged: (value) => setState(() => user.userDetails[detailAttribute] = value),
    ),
    );
  }
}

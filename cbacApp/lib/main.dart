import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/services.dart';

import 'registration.dart';

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



import 'package:flutter/material.dart';

import 'user.dart';


import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:developer' as developer;


class GenerateScreen extends StatefulWidget {
  final User user;
  GenerateScreen({Key key, @required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GenerateScreenState(user);
}

class GenerateScreenState extends State<GenerateScreen> {
  final User user;
  GenerateScreenState(this.user);

  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  //developer.log('log me', name: 'my.app.category');
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "sdsd";
  String _inputErrorText;
  final TextEditingController _textController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    setState((){
      _dataString = '''${widget.user.userDetails['firstName']},${widget.user.userDetails['lastName']},${widget.user.userDetails['street']},${widget.user.userDetails['city']},${widget.user.userDetails['postCode']},${widget.user.userDetails['email']},${widget.user.userDetails['phoneNumber']},${widget.user.symptoms},${widget.user.travelValue},''';
      _inputErrorText = null;
    });
    return  Container(
      color: const Color(0xFFFFFFFF),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(
            padding: const EdgeInsets.all(32),
            child: Text('''
              First Name: ${widget.user.userDetails['firstName']}
              Last Name ${widget.user.userDetails['lastName']}
              Street: ${widget.user.userDetails['street']}
              City: ${widget.user.userDetails['city']}
              PostCode: ${widget.user.userDetails['postCode']}
              Email: ${widget.user.userDetails['postCode']}''',
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child:  Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: _dataString,
                  size: 1.0 * bodyHeight,
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ],
      ),
    );
  }
}

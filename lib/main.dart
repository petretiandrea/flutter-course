import 'package:flutter/material.dart';
import 'package:flutter_course_1/text.dart';
import 'package:flutter_course_1/textcontrol.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextAppState();
}

class _TextAppState extends State<MyApp> {
  final _texts = const ['Some text1', 'Some text2', 'Some text 3'];

  var _currentTextIndex = 0;

  void _changeText() => setState(() {
        _currentTextIndex = (_currentTextIndex + 1) % _texts.length;
        print('Pressed');
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('TextApp'),
          ),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextVisualizer(_texts, _currentTextIndex),
                TextControl(_changeText)
              ],
            ),
          )),
    );
  }
}

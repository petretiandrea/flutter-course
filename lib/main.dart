import 'package:flutter/material.dart';
import 'package:flutter_course_1/text.dart';
import 'package:flutter_course_1/textcontrol.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _texts = const ['Some text1', 'Some text2', 'Some text 3'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('TextApp'),
        ),
        body: Center(
          child: TextControl(_texts),
        ),
      ),
    );
  }
}

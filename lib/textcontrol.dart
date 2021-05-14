import 'package:flutter/material.dart';
import 'package:flutter_course_1/text.dart';

class TextControl extends StatefulWidget {
  final List<String> texts;

  TextControl(this.texts);

  @override
  State<StatefulWidget> createState() {
    return _TextControlState(texts);
  }
}

class _TextControlState extends State<TextControl> {
  final List<String> _texts;
  int _currentIndex;

  _TextControlState(List<String> texts)
      : this._texts = texts,
        _currentIndex = 0;

  void _changeText() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _texts.length;
      print('Pressed');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextVisualizer(_texts[_currentIndex]),
          TextButton(
            child: Text('Change Text'),
            onPressed: _changeText,
            style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextVisualizer extends StatelessWidget {
  final String text;

  TextVisualizer(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 25),
    );
  }
}

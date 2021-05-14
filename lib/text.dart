import 'package:flutter/material.dart';

class TextVisualizer extends StatelessWidget {
  final List<String> texts;
  final int index;

  TextVisualizer(this.texts, this.index);

  @override
  Widget build(BuildContext context) {
    return Text(
      texts[index],
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 25),
    );
  }
}

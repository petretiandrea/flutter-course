import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final void Function() changeHandler;

  TextControl(this.changeHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Text('Change Text'),
        onPressed: changeHandler,
        style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            textStyle: TextStyle(color: Colors.white)),
      ),
    );
  }
}

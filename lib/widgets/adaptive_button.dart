import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdapativeFlatButton extends StatelessWidget {
  final String text;
  final void Function() pressHandler;

  AdapativeFlatButton(this.text, this.pressHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              this.text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: this.pressHandler,
          )
        : ElevatedButton(
            child: Text(this.text),
            onPressed: this.pressHandler,
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}

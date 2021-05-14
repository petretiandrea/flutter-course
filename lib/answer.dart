import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final void Function() selectHandler;
  final String text;

  Answer(this.text, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(this.text),
        onPressed: this.selectHandler,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
            foregroundColor:
                MaterialStateProperty.all(Colors.white) // text color
            ),
      ),
    );
  }
}

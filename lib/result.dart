import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final void Function() restartHandler;

  Result(this.score, this.restartHandler);

  // an example of getter
  String get resultPhrase {
    if (score <= 8) {
      return 'You are awesome';
    } else if (score <= 12) {
      return 'Pretty likeable';
    } else if (score <= 16) {
      return 'You are ... strange?!';
    } else {
      return 'You are so bad';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            child: Text('Restart quiz!'),
            onPressed: restartHandler,
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.green)),
          )
        ],
      ),
    );
  }
}

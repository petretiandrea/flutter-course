import 'package:flutter/material.dart';
import 'package:flutter_course_1/answer.dart';
import 'package:flutter_course_1/question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> _questions;
  final void Function(int) _answerHandler;
  final int _questionIndex;

  Quiz({@required questions, @required answerHandler, @required questionIndex})
      : _questions = questions,
        _answerHandler = answerHandler,
        _questionIndex = questionIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(_questions[_questionIndex]['questionText']),
        ...(_questions[_questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) =>
                Answer(answer['text'], () => _answerHandler(answer['score'])))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_course_1/answer.dart';
import 'package:flutter_course_1/question.dart';
import 'package:flutter_course_1/quiz.dart';
import 'package:flutter_course_1/result.dart';

// void main() {
// main entrypoint for app
//  runApp(MyApp());
// }

void main() => runApp(MyApp());

class Person {
  String name;
  int age;

  Person(this.name, this.age) {
    // direct storage the arguments to class member
    // could be used with {}
  }
  // Person({String inputname, int age}) {
  // with {} all parameters are optional and must be used as named
  // also exists @required a built-in flutter option, that allow to require
  // an optional parameter
  // }

  // that's important its like immutable list
  // its forbiddend to add element to const list
  // var a = const [];
}

// when data ui change ist recreated
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

// this is not recreated to keep the state
class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'What is your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 6},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 2}
      ]
    },
    {
      'questionText': 'What is your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 2},
        {'text': 'Elephant', 'score': 10},
        {'text': 'Lion', 'score': 11}
      ]
    },
    {
      'questionText': 'What is your favorite instructor?',
      'answers': [
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1}
      ]
    }
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _restartQuiz() {
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }

  void _answerQuestion(int score) {
    if (_questionIndex < _questions.length) {
      setState(() {
        _totalScore += score;
        _questionIndex += 1;
      });
    }
    print('${_questionIndex}, ${_totalScore}');
  }

  bool _availableQuestions() => _questionIndex < _questions.length;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('MyApp'),
          ),
          body: _availableQuestions()
              ? Quiz(
                  questions: _questions,
                  answerHandler: _answerQuestion,
                  questionIndex: _questionIndex,
                )
              : Result(_totalScore, _restartQuiz)),
    );
  }
}

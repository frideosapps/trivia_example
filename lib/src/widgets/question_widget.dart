import 'package:flutter/material.dart';

import '../blocs/trivia_bloc.dart';
import '../models/question.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({this.bloc, this.question});

  final Question question;
  final TriviaBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      alignment: Alignment.center,
      height: 18 * 4.0,
      child: Text(
        '${bloc.triviaState.value.questionIndex} - ${question.question}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 2.0,
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}

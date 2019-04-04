import 'package:flutter/material.dart';

//
// ** Trivia page **
//
const textColor = Colors.white;

const scoreHeaderStyle = TextStyle(
  letterSpacing: 2.0,
  color: Colors.orange,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  shadows: [
    Shadow(
      blurRadius: 2.0,
      color: Colors.red,
    ),
  ],
);
const questionsHeaderStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic);

const answerBoxColor = Color(0xff283593);

const questionCircleAvatarBackground = Color(0xff22273a);

const questionCircleAvatarRadius = 14.0;

const answersLeadingStyle =
    TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700);

const answersStyle =
    TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);

//
// ** Summary page **
//
const dividerHeight = 12.0;
const dividerColor = Colors.white;

const circleAvatarRadius = 12.0;
//const circleAvatarBackground = Colors.blue;
const circleAvatarBackground = Color(0xff4a5580);

const summaryScoreStyle = TextStyle(
    color: Colors.lime,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic);

const questionHeaderStyle = TextStyle(
    color: Colors.white54,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic);

const questionStyle = TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const correctsHeaderStyle = TextStyle(
  color: Colors.greenAccent,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const wrongsHeaderStyle = TextStyle(
  color: Colors.redAccent,
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const notAnsweredHeaderStyle = TextStyle(
  color: Color(0xffe1e1e1),
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const correctAnswerStyle =
    TextStyle(color: Colors.green, fontWeight: FontWeight.w600);

const wrongAnswerStyle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic);

const notChosenStyle = TextStyle(
    color: Color(0xffe1e1e1),
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic);

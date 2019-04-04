import 'dart:async';

import 'package:frideos_core/frideos_core.dart';

import '../models/models.dart';
import '../models/question.dart';
import '../models/trivia_stats.dart';

const questionTime = 10000;
const refreshTime = 100;

class TriviaBloc {
  TriviaBloc({this.countdownStream, this.questions, this.tabController}) {
    // Getting the questions from the API
    questions.onChange((data) {
      if (data.isNotEmpty) {
        final questions = data..shuffle();
        _startTrivia(questions);
      }
    });

    countdownStream.outTransformed.listen((data) {
      countdown = int.parse(data) * 1000;
    });
  }

  // STREAMS
  final StreamedValue<AppTab> tabController;
  final triviaState = StreamedValue<TriviaState>(initialData: TriviaState());
  final StreamedList<Question> questions;
  final currentQuestion = StreamedValue<Question>();
  final currentTime = StreamedValue<int>(initialData: 0);
  final countdownBar = StreamedValue<double>();
  final answersAnimation = StreamedValue<AnswerAnimation>(
      initialData: AnswerAnimation(chosenAnswerIndex: 0, startPlaying: false));

  // QUESTIONS, ANSWERS, STATS
  int index = 0;
  String chosenAnswer;
  final stats = TriviaStats();

  // TIMER, COUNTDOWN
  final StreamedTransformed<String, String> countdownStream;
  int countdown; // Milliseconds
  Timer timer;

  void _startTrivia(List<Question> data) {
    index = 0;
    triviaState.value.questionIndex = 1;

    // To show the main page and summary buttons
    triviaState.value.isTriviaEnd = false;

    // Reset the stats
    stats.reset();

    // To set the initial question (in this case the countdown
    // bar animation won't start).
    currentQuestion.value = data.first;

    Timer(Duration(milliseconds: 1000), () {
      // Setting this flag to true on changing the question
      // the countdown bar animation starts.
      triviaState.value.isTriviaPlaying = true;

      // Stream the first question again with the countdown bar
      // animation.
      currentQuestion.value = data[index];

      playTrivia();
    });
  }

  void playTrivia() {
    timer = Timer.periodic(Duration(milliseconds: refreshTime), (Timer t) {
      currentTime.value = refreshTime * t.tick;

      if (currentTime.value > countdown) {
        currentTime.value = 0;
        timer.cancel();
        notAnswered(currentQuestion.value);
        _nextQuestion();
      }
    });
  }

  void _endTrivia() {
    // RESET
    timer.cancel();
    currentTime.value = 0;
    triviaState.value.isTriviaEnd = true;
    triviaState.refresh();
    stopTimer();

    Timer(Duration(milliseconds: 1500), () {
      // this is reset here to not trigger the start of the
      // countdown animation while waiting for the summary page.
      triviaState.value.isAnswerChosen = false;
      // Show the summary page after 1.5s
      tabController.value = AppTab.summary;

      // Clear the last question so that it doesn't appear
      // in the next game
      currentQuestion.value = null;
    });
  }

  void notAnswered(Question question) {
    stats.addNoAnswer(question);
  }

  void checkAnswer(Question question, String answer) {
    if (!triviaState.value.isTriviaEnd) {
      question.chosenAnswerIndex = question.answers.indexOf(answer);
      if (question.isCorrect(answer)) {
        stats.addCorrect(question);
      } else {
        stats.addWrong(question);
      }

      timer.cancel();
      currentTime.value = 0;

      _nextQuestion();
    }
  }

  void _nextQuestion() {
    index++;

    if (index < questions.length) {
      triviaState.value.questionIndex++;
      currentQuestion.value = questions.value[index];
      playTrivia();
    } else {
      _endTrivia();
    }
  }

  void stopTimer() {
    // Stop the timer
    timer.cancel();
    // By setting this flag to true the countdown animation will stop
    triviaState.value.isAnswerChosen = true;
    triviaState.refresh();
  }

  void onChosenAnswer(String answer) {
    chosenAnswer = answer;

    stopTimer();

    // Set the chosenAnswer so that the answer widget can put it last on the
    // stack.
    answersAnimation.value.chosenAnswerIndex =
        currentQuestion.value.answers.indexOf(answer);
    answersAnimation.refresh();
  }

  void onChosenAnwserAnimationEnd() {
    // Reset the flag so that the countdown animation can start
    triviaState.value.isAnswerChosen = false;
    triviaState.refresh();

    checkAnswer(currentQuestion.value, chosenAnswer);
  }

  void dispose() {
    answersAnimation.dispose();
    countdownBar.dispose();
    countdownStream.dispose();
    currentQuestion.dispose();
    currentTime.dispose();
    questions.dispose();
    tabController.dispose();
    triviaState.dispose();
  }
}

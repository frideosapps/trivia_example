enum QuestionDifficulty { easy, medium, hard }

enum QuestionType { boolean, multiple }

class QuestionModel {
  QuestionModel({this.question, this.correctAnswer, this.incorrectAnswers});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        question: json['question'],
        correctAnswer: json['correct_answer'],
        incorrectAnswers: (json['incorrect_answers'] as List)
            .map((answer) => answer.toString())
            .toList());
  }

  String question;
  String correctAnswer;
  List<String> incorrectAnswers;
}

class Question {
  Question({this.question, this.answers, this.correctAnswerIndex});
  factory Question.fromQuestionModel(QuestionModel model) {
    final List<String> answers = []
      ..add(model.correctAnswer)
      ..addAll(model.incorrectAnswers)
      ..shuffle();

    final index = answers.indexOf(model.correctAnswer);

    return Question(
        question: model.question, answers: answers, correctAnswerIndex: index);
  }

  String question;
  List<String> answers;
  int correctAnswerIndex;
  int chosenAnswerIndex;

  bool isCorrect(String answer) {
    return answers.indexOf(answer) == correctAnswerIndex;
  }

  bool isChosen(String answer) {
    return answers.indexOf(answer) == chosenAnswerIndex;
  }
}

import 'question.dart';

class TriviaStats {
  TriviaStats() {
    corrects = [];
    wrongs = [];
    noAnswered = [];
    score = 0;
  }

  List<Question> corrects;
  List<Question> wrongs;
  List<Question> noAnswered;
  int score;

  void addCorrect(Question question) {
    corrects.add(question);
    score += 10;
  }

  void addWrong(Question question) {
    wrongs.add(question);
    score -= 4;
  }

  void addNoAnswer(Question question) {
    noAnswered.add(question);
    score -= 2;
  }

  void reset() {
    corrects = [];
    wrongs = [];
    noAnswered = [];
    score = 0;
  }
}

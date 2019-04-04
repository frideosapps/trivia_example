import 'package:frideos_core/frideos_core.dart';

import '../models/category.dart';
import '../models/question.dart';

abstract class QuestionsAPI {
  Future<bool> getCategories(StreamedList<Category> categories);
  Future<bool> getQuestions(
      {StreamedList<Question> questions,
      int number,
      Category category,
      QuestionDifficulty difficulty,
      QuestionType type});
}

import 'dart:async';

import 'dart:convert' as convert;

import 'package:frideos_core/frideos_core.dart';

import '../models/category.dart';
import '../models/question.dart';

import 'api_interface.dart';

class MockAPI implements QuestionsAPI {
  @override
  Future<bool> getCategories(StreamedList<Category> categories) async {
    categories.value = [];

    categories.addElement(
      Category(id: 1, name: 'Category demo'),
    );
    return true;
  }

  @override
  Future<bool> getQuestions(
      {StreamedList<Question> questions,
      int number,
      Category category,
      QuestionDifficulty difficulty,
      QuestionType type}) async {
    const json =
        "{\"response_code\":0,\"results\":[{\"category\":\"General Knowledge\",\"type\":\"multiple\",\"difficulty\":\"easy\",\"question\":\"What is the largest organ of the human body?\",\"correct_answer\":\"Skin\",\"incorrect_answers\":[\"Heart\",\"large Intestine\",\"Liver\"]},{\"category\":\"Science: Mathematics\",\"type\":\"multiple\",\"difficulty\":\"easy\",\"question\":\"In Roman Numerals, what does XL equate to?\",\"correct_answer\":\"40\",\"incorrect_answers\":[\"60\",\"15\",\"90\"]},{\"category\":\"Entertainment: Television\",\"type\":\"multiple\",\"difficulty\":\"easy\",\"question\":\"Grant Gustin plays which superhero on the CW show of the same name?\",\"correct_answer\":\"The Flash\",\"incorrect_answers\":[\"The Arrow\",\"Black Canary\",\"Daredevil\"]},{\"category\":\"Entertainment: Cartoon & Animations\",\"type\":\"multiple\",\"difficulty\":\"easy\",\"question\":\"In the 1993 Disney animated series, what is the name of Bonker\'s second partner?\",\"correct_answer\":\"Miranda Wright\",\"incorrect_answers\":[\"Dick Tracy\",\"Eddie Valiant\",\"Dr. Ludwig von Drake\"]},{\"category\":\"Geography\",\"type\":\"multiple\",\"difficulty\":\"easy\",\"question\":\"How many countries does Mexico border?\",\"correct_answer\":\"3\",\"incorrect_answers\":[\"2\",\"4\",\"1\"]}]}";

    final jsonResponse = convert.jsonDecode(json);

    final result = (jsonResponse['results'] as List)
        .map((question) => QuestionModel.fromJson(question));

    questions.value =
        result.map((question) => Question.fromQuestionModel(question)).toList();

    return true;
  }
}

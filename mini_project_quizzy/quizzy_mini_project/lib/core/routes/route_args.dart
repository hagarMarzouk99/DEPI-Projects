import '../../screens/quiz/data/models/quiz_result_model.dart';

/// Arguments for [AppRoutes.quiz].
class QuizArgs {
  final String categoryId;
  final String categoryTitle;
  final String? quizTitle;

  const QuizArgs({
    required this.categoryId,
    required this.categoryTitle,
    this.quizTitle,
  });
}

/// Arguments for [AppRoutes.results].
class ResultsArgs {
  final QuizResultModel result;

  /// Current daily streak, shown on the results screen when > 0.
  final int streakDays;

  const ResultsArgs({required this.result, this.streakDays = 0});
}

// [AppRoutes.review] takes a QuizResultModel directly as its argument.

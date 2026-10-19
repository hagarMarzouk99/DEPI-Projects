import '../../quiz_constants.dart';
import 'question_model.dart';

/// Final result of a submitted quiz. Used by the results and review screens.
class QuizResultModel {
  final String categoryId;
  final String categoryTitle;
  final String? quizTitle;
  final List<QuestionModel> questions;

  /// Chosen option per question. `null` = skipped (no answer).
  final List<int?> answers;

  /// Seconds the user spent before submitting.
  final int elapsedSeconds;

  const QuizResultModel({
    required this.categoryId,
    required this.categoryTitle,
    required this.quizTitle,
    required this.questions,
    required this.answers,
    required this.elapsedSeconds,
  });

  int get total => questions.length;

  int get correct {
    var count = 0;
    for (var i = 0; i < total; i++) {
      if (answers[i] == questions[i].correctIndex) count++;
    }
    return count;
  }

  int get skipped => answers.where((a) => a == null).length;

  int get incorrect => total - correct - skipped;

  int get xp => correct * kXpPerCorrect;

  /// 0.0 - 1.0
  double get accuracy => total == 0 ? 0 : correct / total;

  bool get passed => accuracy >= kPassAccuracy;

  /// Average seconds spent per question.
  int get paceSeconds => total == 0 ? 0 : (elapsedSeconds / total).round();

  String get paceLabel {
    if (paceSeconds <= kFastPaceSeconds) return 'Fast Pace';
    if (paceSeconds <= kSecondsPerQuestion) return 'Standard Pace';
    return 'Slow Pace';
  }
}

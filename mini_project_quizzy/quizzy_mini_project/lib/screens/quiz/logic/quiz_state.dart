import '../data/models/question_model.dart';

/// Everything the quiz screen needs to draw itself at any moment.
class QuizState {
  final List<QuestionModel> questions;

  /// Chosen option for each question (same order as [questions]).
  /// `null` = not answered yet. The user can change it until submitting.
  final List<int?> answers;

  final int currentIndex;

  /// Countdown for the WHOLE quiz.
  final int remainingSeconds;
  final int totalSeconds;

  /// True after the user submitted (or the time ran out).
  final bool isFinished;

  const QuizState({
    required this.questions,
    required this.answers,
    required this.currentIndex,
    required this.remainingSeconds,
    required this.totalSeconds,
    required this.isFinished,
  });

  factory QuizState.initial() => const QuizState(
        questions: [],
        answers: [],
        currentIndex: 0,
        remainingSeconds: 0,
        totalSeconds: 0,
        isFinished: false,
      );

  int get total => questions.length;
  bool get isLoaded => questions.isNotEmpty;
  bool get isFirst => currentIndex == 0;
  bool get isLast => currentIndex >= total - 1;
  QuestionModel get currentQuestion => questions[currentIndex];

  int? get selectedIndex => isLoaded ? answers[currentIndex] : null;
  int get answeredCount => answers.where((a) => a != null).length;
  int get unansweredCount => total - answeredCount;
  int get elapsedSeconds => totalSeconds - remainingSeconds;

  QuizState copyWith({
    List<QuestionModel>? questions,
    List<int?>? answers,
    int? currentIndex,
    int? remainingSeconds,
    int? totalSeconds,
    bool? isFinished,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      currentIndex: currentIndex ?? this.currentIndex,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}

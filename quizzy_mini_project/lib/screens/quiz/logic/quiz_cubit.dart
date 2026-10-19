import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/quiz_result_model.dart';
import '../data/quiz_repository.dart';
import '../quiz_constants.dart';
import 'quiz_state.dart';

/// All quiz logic: loading questions, saving answers, moving between
/// questions, the global countdown and submitting.
/// The UI only reads [QuizState] and calls the public methods below.
class QuizCubit extends Cubit<QuizState> {
  QuizCubit({
    required this.categoryId,
    required this.categoryTitle,
    this.quizTitle,
    QuizRepository? repository,
  })  : _repository = repository ?? QuizRepository(),
        super(QuizState.initial());

  final String categoryId;
  final String categoryTitle;
  final String? quizTitle;
  final QuizRepository _repository;
  Timer? _timer;

  /// Loads the questions and starts the countdown.
  void start() {
    final questions = _repository.getQuestions(categoryId);
    final totalSeconds = questions.length * kSecondsPerQuestion;
    emit(QuizState(
      questions: questions,
      answers: List<int?>.filled(questions.length, null),
      currentIndex: 0,
      remainingSeconds: totalSeconds,
      totalSeconds: totalSeconds,
      isFinished: false,
    ));
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    if (state.isFinished) return;
    final left = state.remainingSeconds - 1;
    if (left <= 0) {
      // Time is over: submit automatically, unanswered = skipped.
      emit(state.copyWith(remainingSeconds: 0));
      submit();
    } else {
      emit(state.copyWith(remainingSeconds: left));
    }
  }

  /// Saves the chosen option for the current question.
  /// The user can tap another option to change it before submitting.
  void selectAnswer(int optionIndex) {
    if (!state.isLoaded || state.isFinished) return;
    final updated = List<int?>.from(state.answers);
    updated[state.currentIndex] = optionIndex;
    emit(state.copyWith(answers: updated));
  }

  void next() {
    if (!state.isLoaded || state.isFinished || state.isLast) return;
    emit(state.copyWith(currentIndex: state.currentIndex + 1));
  }

  void previous() {
    if (!state.isLoaded || state.isFinished || state.isFirst) return;
    emit(state.copyWith(currentIndex: state.currentIndex - 1));
  }

  /// Ends the quiz. The screen reacts to `isFinished` and opens the results.
  void submit() {
    if (!state.isLoaded || state.isFinished) return;
    _timer?.cancel();
    emit(state.copyWith(isFinished: true));
  }

  QuizResultModel get result => QuizResultModel(
        categoryId: categoryId,
        categoryTitle: categoryTitle,
        quizTitle: quizTitle,
        questions: state.questions,
        answers: state.answers,
        elapsedSeconds: state.elapsedSeconds,
      );

  @override
  Future<void> close() {
    _timer?.cancel(); // don't keep a timer running after the screen is gone
    return super.close();
  }
}

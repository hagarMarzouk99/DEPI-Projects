import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/local_storage.dart';
import '../../../screens/quiz/data/models/quiz_result_model.dart';
import '../../../screens/quiz/quiz_constants.dart';
import 'progress_state.dart';

/// XP, level, average score, streak and badges. Loaded from SharedPreferences
/// at startup and saved again after every finished quiz.
class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit(LocalStorage storage)
      : _storage = storage,
        super(_load(storage));

  final LocalStorage _storage;

  static ProgressState _load(LocalStorage s) => ProgressState(
        quizzesTaken: s.quizzesTaken,
        totalCorrect: s.totalCorrect,
        totalQuestions: s.totalQuestions,
        xp: s.xp,
        streakDays: s.streakDays,
        lastPlayedDay: s.lastPlayedDay,
        perfectScores: s.perfectScores,
        fastQuizzes: s.fastQuizzes,
      );

  /// Re-reads the saved data (used after a new account replaced the old one).
  void reload() => emit(_load(_storage));

  /// Adds a finished quiz to the player's progress.
  /// [now] is only a parameter so the streak logic can be tested.
  void recordResult(QuizResultModel result, {DateTime? now}) {
    final today = _dayNumber(now ?? DateTime.now());
    final s = state;

    // Streak: same day = unchanged, next day = +1, any gap = starts again.
    final int streak;
    if (s.lastPlayedDay == today) {
      streak = s.streakDays < 1 ? 1 : s.streakDays;
    } else if (s.lastPlayedDay == today - 1) {
      streak = s.streakDays + 1;
    } else {
      streak = 1;
    }

    final isPerfect = result.total > 0 && result.correct == result.total;
    final isFast = result.passed && result.paceSeconds <= kFastPaceSeconds;

    final next = s.copyWith(
      quizzesTaken: s.quizzesTaken + 1,
      totalCorrect: s.totalCorrect + result.correct,
      totalQuestions: s.totalQuestions + result.total,
      xp: s.xp + result.xp,
      streakDays: streak,
      lastPlayedDay: today,
      perfectScores: s.perfectScores + (isPerfect ? 1 : 0),
      fastQuizzes: s.fastQuizzes + (isFast ? 1 : 0),
    );

    emit(next);
    unawaited(_storage.saveProgress(
      quizzesTaken: next.quizzesTaken,
      totalCorrect: next.totalCorrect,
      totalQuestions: next.totalQuestions,
      xp: next.xp,
      streakDays: next.streakDays,
      lastPlayedDay: next.lastPlayedDay,
      perfectScores: next.perfectScores,
      fastQuizzes: next.fastQuizzes,
    ));
  }

  /// Days since 1970, computed in UTC so daylight saving can't break it.
  static int _dayNumber(DateTime d) =>
      DateTime.utc(d.year, d.month, d.day).millisecondsSinceEpoch ~/
      Duration.millisecondsPerDay;
}

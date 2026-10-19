/// Seconds given per question. The quiz has ONE countdown for the whole
/// quiz: total time = number of questions * this value (10 questions = 5 min).
const int kSecondsPerQuestion = 30;

/// XP earned for every correct answer (8 correct = 120 XP, like the design).
const int kXpPerCorrect = 15;

/// Minimum accuracy (0.0 - 1.0) to be marked as "Passed".
const double kPassAccuracy = 0.7;

/// Average seconds per question at or below this = "Fast Pace".
const int kFastPaceSeconds = 15;

/// 304 -> "05:04"
String formatClock(int seconds) {
  final m = seconds ~/ 60;
  final s = seconds % 60;
  return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
}

/// 222 -> "3m 42s", 40 -> "40s"
String formatElapsed(int seconds) {
  final m = seconds ~/ 60;
  final s = seconds % 60;
  return m > 0 ? '${m}m ${s}s' : '${s}s';
}

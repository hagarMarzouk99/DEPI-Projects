/// XP needed to move from one level to the next (700 / 1000 XP in the design).
const int kXpPerLevel = 1000;

/// Badge rules shown on the profile.
const int kOnFireStreakDays = 3; // play 3 days in a row
const int kMasterLevel = 10; // reach level 10

/// Everything the Profile screen shows about the player's progress.
class ProgressState {
  final int quizzesTaken;
  final int totalCorrect;
  final int totalQuestions;
  final int xp;
  final int streakDays;

  /// Day number (days since 1970) of the last quiz, -1 = never played.
  final int lastPlayedDay;

  /// Quizzes finished with every answer correct.
  final int perfectScores;

  /// Quizzes passed at a "Fast Pace".
  final int fastQuizzes;

  const ProgressState({
    this.quizzesTaken = 0,
    this.totalCorrect = 0,
    this.totalQuestions = 0,
    this.xp = 0,
    this.streakDays = 0,
    this.lastPlayedDay = -1,
    this.perfectScores = 0,
    this.fastQuizzes = 0,
  });

  int get level => xp ~/ kXpPerLevel + 1;
  int get xpInLevel => xp % kXpPerLevel;
  int get xpToNextLevel => kXpPerLevel - xpInLevel;

  /// 0.0 - 1.0 progress inside the current level.
  double get levelProgress => xpInLevel / kXpPerLevel;

  /// Average accuracy over every question answered, in percent.
  int get averageScorePercent => totalQuestions == 0
      ? 0
      : (totalCorrect / totalQuestions * 100).round();

  // Badges
  bool get hasChampion => perfectScores >= 1;
  bool get hasOnFire => streakDays >= kOnFireStreakDays;
  bool get hasSpeedster => fastQuizzes >= 1;
  bool get hasMaster => level >= kMasterLevel;

  ProgressState copyWith({
    int? quizzesTaken,
    int? totalCorrect,
    int? totalQuestions,
    int? xp,
    int? streakDays,
    int? lastPlayedDay,
    int? perfectScores,
    int? fastQuizzes,
  }) {
    return ProgressState(
      quizzesTaken: quizzesTaken ?? this.quizzesTaken,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      xp: xp ?? this.xp,
      streakDays: streakDays ?? this.streakDays,
      lastPlayedDay: lastPlayedDay ?? this.lastPlayedDay,
      perfectScores: perfectScores ?? this.perfectScores,
      fastQuizzes: fastQuizzes ?? this.fastQuizzes,
    );
  }
}

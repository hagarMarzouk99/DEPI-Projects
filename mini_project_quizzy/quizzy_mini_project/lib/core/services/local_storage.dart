import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around [SharedPreferences].
///
/// Every key the app saves lives in this file, so no screen or cubit has to
/// deal with raw string keys. It is created once in `main()` and shared with
/// the whole app through a RepositoryProvider.
class LocalStorage {
  LocalStorage(this._prefs);

  final SharedPreferences _prefs;

  static Future<LocalStorage> init() async =>
      LocalStorage(await SharedPreferences.getInstance());

  // ---------------------------------------------------------------- keys
  static const _kSeenOnboarding = 'seen_onboarding';

  static const _kIsLoggedIn = 'is_logged_in';
  static const _kUserName = 'user_name';
  static const _kUserEmail = 'user_email';
  static const _kPasswordHash = 'user_password_hash';

  static const _kDarkTheme = 'settings_dark_theme';
  static const _kNotifications = 'settings_notifications';

  static const _kQuizzesTaken = 'progress_quizzes_taken';
  static const _kTotalCorrect = 'progress_total_correct';
  static const _kTotalQuestions = 'progress_total_questions';
  static const _kXp = 'progress_xp';
  static const _kStreakDays = 'progress_streak_days';
  static const _kLastPlayedDay = 'progress_last_played_day';
  static const _kPerfectScores = 'progress_perfect_scores';
  static const _kFastQuizzes = 'progress_fast_quizzes';

  static const _progressKeys = [
    _kQuizzesTaken,
    _kTotalCorrect,
    _kTotalQuestions,
    _kXp,
    _kStreakDays,
    _kLastPlayedDay,
    _kPerfectScores,
    _kFastQuizzes,
  ];

  // ---------------------------------------------------------- onboarding
  bool get seenOnboarding => _prefs.getBool(_kSeenOnboarding) ?? false;
  Future<void> setSeenOnboarding(bool value) =>
      _prefs.setBool(_kSeenOnboarding, value);

  // ------------------------------------------------------------- account
  bool get isLoggedIn => _prefs.getBool(_kIsLoggedIn) ?? false;
  Future<void> setLoggedIn(bool value) => _prefs.setBool(_kIsLoggedIn, value);

  String? get userName => _prefs.getString(_kUserName);
  String? get userEmail => _prefs.getString(_kUserEmail);
  String? get passwordHash => _prefs.getString(_kPasswordHash);

  bool get hasAccount => userEmail != null && passwordHash != null;

  Future<void> saveAccount({
    required String name,
    required String email,
    required String passwordHash,
  }) async {
    await _prefs.setString(_kUserName, name);
    await _prefs.setString(_kUserEmail, email);
    await _prefs.setString(_kPasswordHash, passwordHash);
  }

  // ------------------------------------------------------------ settings
  bool get isDarkTheme => _prefs.getBool(_kDarkTheme) ?? false;
  Future<void> setDarkTheme(bool value) => _prefs.setBool(_kDarkTheme, value);

  bool get notificationsEnabled => _prefs.getBool(_kNotifications) ?? true;
  Future<void> setNotificationsEnabled(bool value) =>
      _prefs.setBool(_kNotifications, value);

  // ------------------------------------------------------------ progress
  int get quizzesTaken => _prefs.getInt(_kQuizzesTaken) ?? 0;
  int get totalCorrect => _prefs.getInt(_kTotalCorrect) ?? 0;
  int get totalQuestions => _prefs.getInt(_kTotalQuestions) ?? 0;
  int get xp => _prefs.getInt(_kXp) ?? 0;
  int get streakDays => _prefs.getInt(_kStreakDays) ?? 0;

  /// Day number (days since 1970) of the last quiz, -1 = never played.
  int get lastPlayedDay => _prefs.getInt(_kLastPlayedDay) ?? -1;
  int get perfectScores => _prefs.getInt(_kPerfectScores) ?? 0;
  int get fastQuizzes => _prefs.getInt(_kFastQuizzes) ?? 0;

  Future<void> saveProgress({
    required int quizzesTaken,
    required int totalCorrect,
    required int totalQuestions,
    required int xp,
    required int streakDays,
    required int lastPlayedDay,
    required int perfectScores,
    required int fastQuizzes,
  }) async {
    await _prefs.setInt(_kQuizzesTaken, quizzesTaken);
    await _prefs.setInt(_kTotalCorrect, totalCorrect);
    await _prefs.setInt(_kTotalQuestions, totalQuestions);
    await _prefs.setInt(_kXp, xp);
    await _prefs.setInt(_kStreakDays, streakDays);
    await _prefs.setInt(_kLastPlayedDay, lastPlayedDay);
    await _prefs.setInt(_kPerfectScores, perfectScores);
    await _prefs.setInt(_kFastQuizzes, fastQuizzes);
  }

  Future<void> clearProgress() async {
    for (final key in _progressKeys) {
      await _prefs.remove(key);
    }
  }
}

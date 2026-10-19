/// Every route name in the app. Navigate only with these constants:
/// `Navigator.pushNamed(context, AppRoutes.quiz, arguments: QuizArgs(...))`.
class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';

  /// Main shell with the bottom navigation (Home + Profile tabs).
  static const home = '/home';
  static const categories = '/categories';

  static const quiz = '/quiz';
  static const results = '/quiz/results';
  static const review = '/quiz/review';
}

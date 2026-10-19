import 'package:flutter/material.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../screens/main_shell.dart';
import '../../feature/categories/category_screen.dart';
import '../../screens/quiz/data/models/quiz_result_model.dart';
import '../../screens/quiz/presentation/quiz_screen.dart';
import '../../screens/quiz/presentation/results_screen.dart';
import '../../screens/quiz/presentation/review_screen.dart';
import 'app_routes.dart';
import 'route_args.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _page(settings, const SplashScreen());
      case AppRoutes.onboarding:
        return _page(settings, const OnboardingScreen());
      case AppRoutes.login:
        return _page(settings, const LoginScreen());
      case AppRoutes.register:
        return _page(settings, const RegisterScreen());
      case AppRoutes.home:
        return _page(settings, const MainShell());
      case AppRoutes.categories:
        return _page(settings, const CategoryScreen());

      case AppRoutes.quiz:
        final args = settings.arguments;
        if (args is QuizArgs) {
          return _page(
            settings,
            QuizScreen(
              categoryId: args.categoryId,
              categoryTitle: args.categoryTitle,
              quizTitle: args.quizTitle,
            ),
          );
        }
        return _invalid(settings);

      case AppRoutes.results:
        final args = settings.arguments;
        if (args is ResultsArgs) {
          return _page(
            settings,
            ResultsScreen(result: args.result, streakDays: args.streakDays),
          );
        }
        return _invalid(settings);

      case AppRoutes.review:
        final args = settings.arguments;
        if (args is QuizResultModel) {
          return _page(settings, ReviewScreen(result: args));
        }
        return _invalid(settings);

      default:
        return _page(settings, const _PlaceholderScreen('Route not found'));
    }
  }

  /// Passing [settings] keeps the route name, which `popUntil` and
  /// `pushNamedAndRemoveUntil` need in order to find the route later.
  static MaterialPageRoute<dynamic> _page(RouteSettings settings, Widget screen) {
    return MaterialPageRoute(builder: (_) => screen, settings: settings);
  }

  static Route<dynamic> _invalid(RouteSettings settings) => _page(
        settings,
        _PlaceholderScreen('Missing arguments for ${settings.name}'),
      );
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title)));
  }
}

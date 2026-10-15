import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _page(const _PlaceholderScreen('Splash'));
      case AppRoutes.onboarding:
        return _page(const _PlaceholderScreen('Onboarding'));
      case AppRoutes.login:
        return _page(const _PlaceholderScreen('Login'));
      case AppRoutes.register:
        return _page(const _PlaceholderScreen('Register'));
      case AppRoutes.home:
        return _page(const _PlaceholderScreen('Home'));
      default:
        return _page(const _PlaceholderScreen('Route not found'));
    }
  }

  static MaterialPageRoute _page(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title)));
  }
}
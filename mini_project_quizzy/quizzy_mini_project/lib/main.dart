import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_colors.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/services/local_storage.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/auth/logic/auth_cubit.dart';
import 'features/progress/logic/progress_cubit.dart';
import 'features/settings/logic/settings_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await LocalStorage.init();
  runApp(QuizzyApp(storage: storage));
}

class QuizzyApp extends StatelessWidget {
  final LocalStorage storage;

  const QuizzyApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalStorage>.value(value: storage),
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(storage),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(context.read<AuthRepository>()),
          ),
          BlocProvider<SettingsCubit>(create: (_) => SettingsCubit(storage)),
          BlocProvider<ProgressCubit>(create: (_) => ProgressCubit(storage)),
        ],
        child: MaterialApp(
          title: 'Quizzy',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.lightBackground,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          ),
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/services/local_storage.dart';
import '../../auth/data/auth_repository.dart';

class SplashState {
  /// 0.0 - 1.0, drives the loading bar.
  final double progress;

  /// Route to open when the loading is done. Null while still loading.
  final String? destination;

  const SplashState({this.progress = 0, this.destination});
}

/// Runs the loading animation, then decides where the app goes next:
/// first launch -> onboarding, logged in -> home, otherwise -> login.
class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required LocalStorage storage,
    required AuthRepository authRepository,
    this.duration = const Duration(milliseconds: 2500),
  })  : _storage = storage,
        _authRepository = authRepository,
        super(const SplashState());

  final LocalStorage _storage;
  final AuthRepository _authRepository;
  final Duration duration;
  Timer? _timer;

  static const _steps = 100;

  void start() {
    var step = 0;
    _timer = Timer.periodic(duration ~/ _steps, (timer) {
      step++;
      if (step >= _steps) {
        timer.cancel();
        emit(SplashState(progress: 1, destination: _resolveRoute()));
      } else {
        emit(SplashState(progress: step / _steps));
      }
    });
  }

  String _resolveRoute() {
    if (!_storage.seenOnboarding) return AppRoutes.onboarding;
    return _authRepository.hasSession ? AppRoutes.home : AppRoutes.login;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

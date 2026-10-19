import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repository.dart';
import 'auth_state.dart';

/// Owns the current user for the whole app (login, register, logout).
/// It is provided above MaterialApp so Home and Profile can read the user.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(AuthRepository repository)
      : _repository = repository,
        super(AuthState.fromUser(repository.currentUser));

  final AuthRepository _repository;

  Future<void> login({required String email, required String password}) async {
    emit(const AuthState(status: AuthStatus.loading));
    try {
      final user = await _repository.login(email: email, password: password);
      emit(AuthState(status: AuthStatus.authenticated, user: user));
    } on AuthException catch (e) {
      emit(AuthState(status: AuthStatus.failure, message: e.message));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const AuthState(status: AuthStatus.loading));
    try {
      final user = await _repository.register(
        name: name,
        email: email,
        password: password,
      );
      emit(AuthState(status: AuthStatus.authenticated, user: user));
    } on AuthException catch (e) {
      emit(AuthState(status: AuthStatus.failure, message: e.message));
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }
}

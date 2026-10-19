import '../data/user_model.dart';

enum AuthStatus { unauthenticated, loading, authenticated, failure }

class AuthState {
  final AuthStatus status;
  final UserModel? user;

  /// Error text, only set when [status] is [AuthStatus.failure].
  final String? message;

  const AuthState({required this.status, this.user, this.message});

  factory AuthState.fromUser(UserModel? user) => AuthState(
        status:
            user == null ? AuthStatus.unauthenticated : AuthStatus.authenticated,
        user: user,
      );

  bool get isLoading => status == AuthStatus.loading;
  bool get isAuthenticated => status == AuthStatus.authenticated;
}

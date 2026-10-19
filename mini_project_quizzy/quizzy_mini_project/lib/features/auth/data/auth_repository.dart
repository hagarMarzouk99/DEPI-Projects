import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../core/services/local_storage.dart';
import 'user_model.dart';

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}

/// Local-only authentication (the project has no backend).
///
/// One account is kept on the device. The password is never stored as plain
/// text, only a SHA-256 hash of it. When a real backend is added, only this
/// class has to change, the cubit and the screens stay the same.
class AuthRepository {
  AuthRepository(this._storage);

  final LocalStorage _storage;

  /// The logged-in user, or null if nobody is logged in.
  UserModel? get currentUser {
    if (!_storage.isLoggedIn) return null;
    final name = _storage.userName;
    final email = _storage.userEmail;
    if (name == null || email == null) return null;
    return UserModel(name: name, email: email);
  }

  bool get hasSession => currentUser != null;

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final cleanEmail = _normalize(email);
    final existing = _storage.userEmail;

    if (existing != null && existing == cleanEmail) {
      throw const AuthException(
        'An account with this email already exists. Please log in.',
      );
    }
    // A different email replaces the old local account, so it starts fresh.
    if (existing != null) await _storage.clearProgress();

    await _storage.saveAccount(
      name: name.trim(),
      email: cleanEmail,
      passwordHash: _hash(cleanEmail, password),
    );
    await _storage.setLoggedIn(true);
    return UserModel(name: name.trim(), email: cleanEmail);
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    if (!_storage.hasAccount) {
      throw const AuthException(
        'No account found on this device. Please register first.',
      );
    }
    final cleanEmail = _normalize(email);
    if (cleanEmail != _storage.userEmail ||
        _hash(cleanEmail, password) != _storage.passwordHash) {
      throw const AuthException('Incorrect email or password.');
    }
    await _storage.setLoggedIn(true);
    return UserModel(name: _storage.userName ?? '', email: cleanEmail);
  }

  /// Ends the session. The account stays saved so the user can log in again.
  Future<void> logout() => _storage.setLoggedIn(false);

  String _normalize(String email) => email.trim().toLowerCase();

  String _hash(String email, String password) =>
      sha256.convert(utf8.encode('quizzy::$email::$password')).toString();
}

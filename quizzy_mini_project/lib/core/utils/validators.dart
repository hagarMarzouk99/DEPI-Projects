class Validators {
  Validators._();

  static String? name(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Enter your name' : null;

  static String? email(String? v) =>
      (v == null || !v.contains('@')) ? 'Enter a valid email' : null;

  static String? password(String? v) =>
      (v == null || v.length < 6) ? 'At least 6 characters' : null;

  static String? Function(String?) confirmPassword(String original) =>
      (v) => v != original ? 'Passwords do not match' : null;
}
class UserModel {
  final String name;
  final String email;

  const UserModel({required this.name, required this.email});

  /// "Mariam Ahmed" -> "MA", "mariam" -> "M"
  String get initials {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts[1][0]).toUpperCase();
  }

  /// Used in the greeting: "Hey, Mariam".
  String get firstName {
    final parts = name.trim().split(RegExp(r'\s+'));
    return parts.first.isEmpty ? name : parts.first;
  }
}

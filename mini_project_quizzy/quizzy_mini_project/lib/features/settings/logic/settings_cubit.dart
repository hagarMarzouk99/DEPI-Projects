import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/local_storage.dart';

class SettingsState {
  final bool isDark;
  final bool notificationsEnabled;

  const SettingsState({required this.isDark, required this.notificationsEnabled});

  SettingsState copyWith({bool? isDark, bool? notificationsEnabled}) =>
      SettingsState(
        isDark: isDark ?? this.isDark,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      );
}

/// Profile settings. Every change is saved, so it survives a restart.
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(LocalStorage storage)
      : _storage = storage,
        super(SettingsState(
          isDark: storage.isDarkTheme,
          notificationsEnabled: storage.notificationsEnabled,
        ));

  final LocalStorage _storage;

  void setDark(bool value) {
    emit(state.copyWith(isDark: value));
    unawaited(_storage.setDarkTheme(value));
  }

  void setNotifications(bool value) {
    emit(state.copyWith(notificationsEnabled: value));
    unawaited(_storage.setNotificationsEnabled(value));
  }
}

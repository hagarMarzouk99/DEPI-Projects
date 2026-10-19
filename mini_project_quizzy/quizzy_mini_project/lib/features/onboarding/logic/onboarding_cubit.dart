import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/local_storage.dart';

/// State = index of the visible onboarding page.
class OnboardingCubit extends Cubit<int> {
  OnboardingCubit(this._storage) : super(0);

  final LocalStorage _storage;

  void pageChanged(int index) => emit(index);

  /// Remembers that onboarding was seen, so it never shows again.
  Future<void> finish() => _storage.setSeenOnboarding(true);
}

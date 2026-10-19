import 'package:flutter_bloc/flutter_bloc.dart';

/// State = selected bottom-navigation tab (0 = Home, 1 = Profile).
class NavCubit extends Cubit<int> {
  NavCubit() : super(0);

  void select(int index) => emit(index);
}

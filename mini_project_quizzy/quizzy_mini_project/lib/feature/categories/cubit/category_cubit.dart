import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/data_category.dart';
import 'category_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(const CategoriesInitial());
  String _query = '';
  CategoryFilter _filter = CategoryFilter.all;

  void search(String query) { _query = query.trim().toLowerCase(); _applyAndEmit(); }
  void selectFilter(CategoryFilter filter) { _filter = filter; _applyAndEmit(); }

  void _applyAndEmit() {
    final result = categoriesData.where((c) {
      final matchesFilter = switch (_filter) {
        CategoryFilter.all => true,
        CategoryFilter.popular => c.isPopular,
        CategoryFilter.recent => c.isRecent,
        CategoryFilter.trending => c.isTrending,
      };
      final matchesQuery = _query.isEmpty || c.name.toLowerCase().contains(_query) || c.description.toLowerCase().contains(_query);
      return matchesFilter && matchesQuery;
    }).toList();
    emit(CategoriesUpdated(categories: result, selectedFilter: _filter));
  }
}

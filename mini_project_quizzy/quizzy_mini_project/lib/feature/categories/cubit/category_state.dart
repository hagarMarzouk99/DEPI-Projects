import '../model/category_model.dart';
import '../model/data_category.dart';

enum CategoryFilter { all, popular, recent, trending }

extension CategoryFilterLabel on CategoryFilter {
  String get label => switch (this) {
    CategoryFilter.all => 'All',
    CategoryFilter.popular => 'Popular',
    CategoryFilter.recent => 'Recent',
    CategoryFilter.trending => 'Trending',
  };
}

abstract class CategoriesState {
  final List<CategoryModel> categories;
  final CategoryFilter selectedFilter;
  const CategoriesState({required this.categories, required this.selectedFilter});
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial() : super(categories: categoriesData, selectedFilter: CategoryFilter.all);
}

class CategoriesUpdated extends CategoriesState {
  const CategoriesUpdated({required super.categories, required super.selectedFilter});
}

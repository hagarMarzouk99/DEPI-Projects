import 'package:quizzy_mini_project/feature/categories/model/category_model.dart';
import 'package:quizzy_mini_project/feature/categories/model/data_category.dart';

 

enum CategoryFilter { all, popular, recent, trending }

extension CategoryFilterLabel on CategoryFilter {
  String get label {
    switch (this) {
      case CategoryFilter.all:
        return 'All';
      case CategoryFilter.popular:
        return 'Popular';
      case CategoryFilter.recent:
        return 'Recent';
      case CategoryFilter.trending:
        return 'Trending';
    }
  }
}
 
abstract class CategoriesState {
  final List<CategoryModel> categories;
  final CategoryFilter selectedFilter;

  const CategoriesState({
    required this.categories,
    required this.selectedFilter,
  });
}
 
class CategoriesInitial extends CategoriesState {
  const CategoriesInitial()
      : super(
          categories: categoriesData,
          selectedFilter: CategoryFilter.all,
        );
}

 
class CategoriesUpdated extends CategoriesState {
  const CategoriesUpdated({
    required super.categories,
    required super.selectedFilter,
  });
}
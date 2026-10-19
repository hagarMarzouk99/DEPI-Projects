import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/routes/app_routes.dart';
import '../../core/routes/route_args.dart';
import 'cubit/category_cubit.dart';
import 'cubit/category_state.dart';
import 'widgets/category_card.dart';
import 'widgets/category_filter_chips.dart';
import 'widgets/category_header.dart';
import 'widgets/category_search.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  void _openCategory(BuildContext context, String id, String name) {
    // The current offline quiz bank supports science, Flutter/technology and general.
    final quizId = id == 'science' ? 'science' : (id == 'technology' ? 'flutter' : 'general');
    Navigator.pushNamed(context, AppRoutes.quiz, arguments: QuizArgs(categoryId: quizId, categoryTitle: name, quizTitle: '$name Quiz'));
  }
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => CategoriesCubit(),
    child: Builder(builder: (context) => Scaffold(
      body: SafeArea(child: Padding(padding: const EdgeInsets.fromLTRB(16, 16, 16, 8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CategoryHeader(),
        const SizedBox(height: 20),
        CategorySearchBar(onChanged: context.read<CategoriesCubit>().search),
        const SizedBox(height: 14),
        BlocBuilder<CategoriesCubit, CategoriesState>(builder: (context, state) => CategoryFilterChips(selected: state.selectedFilter, onSelected: context.read<CategoriesCubit>().selectFilter)),
        const SizedBox(height: 16),
        BlocBuilder<CategoriesCubit, CategoriesState>(builder: (context, state) {
          if (state.categories.isEmpty) return const Expanded(child: Center(child: Text('No categories found. Try another search.')));
          return Expanded(child: GridView.builder(itemCount: state.categories.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.92), itemBuilder: (context, index) {
            final category = state.categories[index];
            return CategoryCard(category: category, onTap: () => _openCategory(context, category.id, category.name));
          }));
        }),
      ]))),
    )),
  );
}

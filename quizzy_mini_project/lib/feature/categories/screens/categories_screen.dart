import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzy_mini_project/core/routes/app_routes.dart';
import 'package:quizzy_mini_project/feature/categories/cubit/category_cubit.dart';
import 'package:quizzy_mini_project/feature/categories/cubit/category_state.dart';
import 'package:quizzy_mini_project/feature/categories/widgets/category_card.dart';
import 'package:quizzy_mini_project/feature/categories/widgets/category_filter_chips.dart';
import 'package:quizzy_mini_project/feature/categories/widgets/category_header.dart'; // جديد
import 'package:quizzy_mini_project/feature/categories/widgets/category_search_bar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit(),
      child: const _CategoriesView(),
    );
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoriesCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              const CategoryHeader(),  
              const SizedBox(height: 20),  
              const Text(
                'Explore Categories',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Choose a topic and test your knowledge.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              CategorySearchBar(onChanged: cubit.search),
              const SizedBox(height: 12),

              Expanded(
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CategoryFilterChips(
                          selected: state.selectedFilter,
                          onSelected: cubit.selectFilter,
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: state.categories.isEmpty
                              ? const Center(child: Text('No categories found'))
                              : GridView.builder(
                                  itemCount: state.categories.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.95,
                                  ),
                                  itemBuilder: (context, index) {
                                    final category = state.categories[index];
                                    return CategoryCard(
                                      category: category,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.quizDetails,
                                          arguments: category.id,
                                        );
                                      },
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
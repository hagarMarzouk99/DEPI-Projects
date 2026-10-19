import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/constants/app_colors.dart';
import '../feature/categories/category_screen.dart';
import 'home_screen.dart';
import 'logic/nav_cubit.dart';
import 'profile_screen.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});
  static const _pages = <Widget>[HomeScreen(), CategoryScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => NavCubit(),
    child: BlocBuilder<NavCubit, int>(builder: (context, index) => Scaffold(
      body: IndexedStack(index: index, children: _pages),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white, indicatorColor: AppColors.easyBg,
        selectedIndex: index, onDestinationSelected: context.read<NavCubit>().select,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.category_outlined), selectedIcon: Icon(Icons.category), label: 'Categories'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    )),
  );
}

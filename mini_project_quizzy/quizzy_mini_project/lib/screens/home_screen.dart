import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/routes/app_routes.dart';
import '../core/routes/route_args.dart';
import '../features/auth/logic/auth_cubit.dart';
import '../widgets/daily_challenge_card.dart';
import '../widgets/home_header.dart';
import '../widgets/quiz_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _startQuiz(BuildContext context, QuizArgs args) {
    Navigator.pushNamed(context, AppRoutes.quiz, arguments: args);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthCubit cubit) => cubit.state.user);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            HomeHeader(
              userName: user?.firstName ?? 'Player',
              initials: user?.initials ?? '?',
            ),
            const SizedBox(height: 20),
            DailyChallengeCard(
              title: 'General Knowledge Sprint',
              description:
                  'Test your brain with 10 handpicked trivia questions across mixed topics.',
              questions: '10 Questions',
              time: '5 Mins',
              xp: '+250 XP',
              onStart: () => _startQuiz(
                context,
                const QuizArgs(
                  categoryId: 'general',
                  categoryTitle: 'General Knowledge',
                  quizTitle: 'General Knowledge Sprint',
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Explore Categories',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => Navigator.pushNamed(context, AppRoutes.categories),
              borderRadius: BorderRadius.circular(16),
              child: Container(height: 120, alignment: Alignment.center, decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.category_outlined), SizedBox(width: 8), Text('Explore all categories'), Icon(Icons.arrow_forward, size: 16)])),
            ),
            const SizedBox(height: 24),
            const Text(
              'Popular Quizzes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // The offline question bank only has science / flutter / general,
            // so each card opens the closest one.
            QuizCard(
              title: 'World Capitals Master',
              details: '15 Qs • 8 mins',
              rating: '4.9 (1.2k)',
              difficulty: 'Medium',
              icon: Icons.public,
              onTap: () => _startQuiz(
                context,
                const QuizArgs(
                  categoryId: 'general',
                  categoryTitle: 'Geography',
                  quizTitle: 'World Capitals Master',
                ),
              ),
            ),
            const SizedBox(height: 12),
            QuizCard(
              title: 'Tech Innovations 2024',
              details: '10 Qs • 5 mins',
              rating: '4.8 (890)',
              difficulty: 'Easy',
              icon: Icons.devices,
              onTap: () => _startQuiz(
                context,
                const QuizArgs(
                  categoryId: 'flutter',
                  categoryTitle: 'Technology',
                  quizTitle: 'Tech Innovations 2024',
                ),
              ),
            ),
            const SizedBox(height: 12),
            QuizCard(
              title: 'Ancient Civilizations',
              details: '12 Qs • 6 mins',
              rating: '4.9 (2.1k)',
              difficulty: 'Hard',
              icon: Icons.account_balance,
              onTap: () => _startQuiz(
                context,
                const QuizArgs(
                  categoryId: 'general',
                  categoryTitle: 'History',
                  quizTitle: 'Ancient Civilizations',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

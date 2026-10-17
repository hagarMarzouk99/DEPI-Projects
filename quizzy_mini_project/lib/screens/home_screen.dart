import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/daily_challenge_card.dart';
import '../widgets/quiz_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const HomeHeader(userName: 'Mariam', initials: 'MA'),
            const SizedBox(height: 20),
            const DailyChallengeCard(
              title: 'General Knowledge Sprint',
              description:
              'Test your brain with 10 handpicked trivia questions across mixed topics.',
              questions: '10 Questions',
              time: '5 Mins',
              xp: '+250 XP',
            ),
            const SizedBox(height: 24),
            const Text(
              'Explore Categories',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text('Categories (Hagar)'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Popular Quizzes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const QuizCard(
              title: 'World Capitals Master',
              details: '15 Qs • 8 mins',
              rating: '4.9 (1.2k)',
              difficulty: 'Medium',
              icon: Icons.public,
            ),
            const SizedBox(height: 12),
            const QuizCard(
              title: 'Tech Innovations 2024',
              details: '10 Qs • 5 mins',
              rating: '4.8 (890)',
              difficulty: 'Easy',
              icon: Icons.devices,
            ),
            const SizedBox(height: 12),
            const QuizCard(
              title: 'Ancient Civilizations',
              details: '12 Qs • 6 mins',
              rating: '4.9 (2.1k)',
              difficulty: 'Hard',
              icon: Icons.account_balance,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String initials;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5CF05C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.bolt, size: 18),
                ),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('QUIZZY', style: TextStyle(fontSize: 9)),
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1B4B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(Icons.notifications_none),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey, $userName',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E1B4B),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Ready to challenge yourself today?',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFF1E1B4B),
              child: Text(
                initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Search quizzes, topics, friends...',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
              const Icon(Icons.tune, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}
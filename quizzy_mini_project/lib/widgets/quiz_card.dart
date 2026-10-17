import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  final String title;
  final String details;
  final String rating;
  final String difficulty;
  final IconData icon;

  const QuizCard({
    super.key,
    required this.title,
    required this.details,
    required this.rating,
    required this.difficulty,
    required this.icon,
  });

  Color badgeColor() {
    if (difficulty == 'Easy') return Colors.green.shade100;
    if (difficulty == 'Hard') return Colors.red.shade100;
    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor(),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        difficulty,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$details • ⭐ $rating',
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          const Icon(Icons.play_circle),
        ],
      ),
    );
  }
}
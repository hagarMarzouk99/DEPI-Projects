import 'package:flutter/material.dart';

class DailyChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final String questions;
  final String time;
  final String xp;

  const DailyChallengeCard({
    super.key,
    required this.title,
    required this.description,
    required this.questions,
    required this.time,
    required this.xp,
  });

  Widget infoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF3F0FF), Color(0xFFE6F9E8)],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 4, backgroundColor: Colors.green),
                  const SizedBox(width: 6),
                  const Text(
                    'DAILY CHALLENGE',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF5CF05C),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  xp,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1B4B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(description, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.emoji_events,
                  size: 36,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              infoChip(Icons.help_outline, questions),
              const SizedBox(width: 8),
              infoChip(Icons.timer_outlined, time),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E1B4B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Start Quiz'),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
          ),git status
        ],
      ),
    );
  }
}
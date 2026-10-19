import 'package:flutter/material.dart';

import '../../quiz_constants.dart';
import '../quiz_colors.dart';

/// Dark pill with a dot and the remaining quiz time as mm:ss.
/// The dot turns red during the last 30 seconds.
class TimerPill extends StatelessWidget {
  final int remainingSeconds;

  const TimerPill({super.key, required this.remainingSeconds});

  @override
  Widget build(BuildContext context) {
    final isLow = remainingSeconds <= 30;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: QuizColors.navy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isLow ? QuizColors.red : QuizColors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            formatClock(remainingSeconds),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

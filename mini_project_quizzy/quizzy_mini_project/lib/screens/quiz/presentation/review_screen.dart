import 'package:flutter/material.dart';

import '../data/models/quiz_result_model.dart';
import 'quiz_colors.dart';

/// "Review Answers": every question with the user's answer and the correct one.
class ReviewScreen extends StatelessWidget {
  final QuizResultModel result;

  const ReviewScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: QuizColors.background,
      appBar: AppBar(
        backgroundColor: QuizColors.background,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: QuizColors.navy),
        title: const Text(
          'Review Answers',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: QuizColors.navy,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        itemCount: result.total,
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemBuilder: (context, i) => _ReviewCard(
          number: i + 1,
          result: result,
          index: i,
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final int number;
  final QuizResultModel result;
  final int index;

  const _ReviewCard({
    required this.number,
    required this.result,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final question = result.questions[index];
    final chosen = result.answers[index];
    final isSkipped = chosen == null;
    final isCorrect = chosen == question.correctIndex;

    final String statusText;
    final Color statusColor;
    final Color statusBg;
    if (isSkipped) {
      statusText = 'Skipped';
      statusColor = QuizColors.greyText;
      statusBg = QuizColors.grey;
    } else if (isCorrect) {
      statusText = 'Correct';
      statusColor = QuizColors.greenDark;
      statusBg = QuizColors.greenSoft;
    } else {
      statusText = 'Incorrect';
      statusColor = QuizColors.red;
      statusBg = QuizColors.redSoft;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: QuizColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: QuizColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question $number',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: QuizColors.greyText,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            question.text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: QuizColors.navy,
            ),
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < question.options.length; i++)
            _ReviewOption(
              title: question.options[i].title,
              isCorrect: i == question.correctIndex,
              isWrongChoice: i == chosen && i != question.correctIndex,
              isYourChoice: i == chosen,
            ),
        ],
      ),
    );
  }
}

class _ReviewOption extends StatelessWidget {
  final String title;
  final bool isCorrect;
  final bool isWrongChoice;
  final bool isYourChoice;

  const _ReviewOption({
    required this.title,
    required this.isCorrect,
    required this.isWrongChoice,
    required this.isYourChoice,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final IconData icon;
    final Color iconColor;
    if (isCorrect) {
      bg = QuizColors.greenSoft;
      icon = Icons.check_circle;
      iconColor = QuizColors.green;
    } else if (isWrongChoice) {
      bg = QuizColors.redSoft;
      icon = Icons.cancel;
      iconColor = QuizColors.red;
    } else {
      bg = QuizColors.background;
      icon = Icons.radio_button_unchecked;
      iconColor = QuizColors.border;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: QuizColors.navy,
              ),
            ),
          ),
          if (isYourChoice)
            const Text(
              'Your answer',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: QuizColors.greyText,
              ),
            ),
        ],
      ),
    );
  }
}

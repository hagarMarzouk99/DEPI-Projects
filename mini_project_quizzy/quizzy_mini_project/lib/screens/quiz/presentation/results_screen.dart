import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/routes/route_args.dart';
import '../data/models/quiz_result_model.dart';
import '../quiz_constants.dart';
import 'quiz_colors.dart';
import 'widgets/quiz_button.dart';

/// Quiz Result screen: accuracy ring, XP, breakdown and the action buttons.
class ResultsScreen extends StatelessWidget {
  final QuizResultModel result;

  /// Daily streak. The streak chip is hidden when it is 0.
  final int streakDays;

  const ResultsScreen({super.key, required this.result, this.streakDays = 0});

  String get _title {
    final a = result.accuracy;
    if (a >= 0.8) return 'Outstanding Performance!';
    if (a >= 0.6) return 'Good Job!';
    return 'Keep Practicing!';
  }

  String get _message {
    final a = result.accuracy;
    if (a >= 0.8) {
      return 'You demonstrated solid mastery of the core concepts! '
          'Keep up the momentum to reach a new personal best.';
    }
    if (a >= 0.6) {
      return 'You are getting there. Review your mistakes and try again '
          'to improve your score.';
    }
    return 'Do not give up. Review the answers and try again, '
        'you will do better next time.';
  }

  void _goHome(BuildContext context) => Navigator.of(context)
      .popUntil(ModalRoute.withName(AppRoutes.home));

  void _retry(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(
      AppRoutes.quiz,
      arguments: QuizArgs(
        categoryId: result.categoryId,
        categoryTitle: result.categoryTitle,
        quizTitle: result.quizTitle,
      ),
    );
  }

  void _review(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.review, arguments: result);
  }

  @override
  Widget build(BuildContext context) {
    final tags = result.quizTitle == null
        ? result.categoryTitle
        : '${result.categoryTitle} • ${result.quizTitle}';

    return Scaffold(
      backgroundColor: QuizColors.background,
      appBar: AppBar(
        backgroundColor: QuizColors.background,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close, color: QuizColors.navy),
          onPressed: () => _goHome(context),
        ),
        title: const Text(
          'Quiz Result',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: QuizColors.navy,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
          child: Column(
            children: [
              // Trophy
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: QuizColors.green.withValues(alpha: 0.25),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.emoji_events,
                  size: 56,
                  color: Color(0xFFF2B01E),
                ),
              ),
              const SizedBox(height: 14),

              // Category • quiz name
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: QuizColors.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: QuizColors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        tags,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: QuizColors.navy,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              Text(
                _title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: QuizColors.navy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: QuizColors.greyText,
                ),
              ),
              const SizedBox(height: 12),

              // XP + streak
              Wrap(
                spacing: 8,
                children: [
                  _DarkChip(icon: Icons.bolt, text: '+${result.xp} XP'),
                  if (streakDays > 0)
                    _DarkChip(
                      icon: Icons.local_fire_department,
                      text: '$streakDays-Day Streak',
                    ),
                ],
              ),
              const SizedBox(height: 18),

              // Accuracy ring
              _Card(
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox.expand(
                            child: CircularProgressIndicator(
                              value: result.accuracy,
                              strokeWidth: 12,
                              strokeCap: StrokeCap.round,
                              color: QuizColors.green,
                              backgroundColor: QuizColors.grey,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${result.correct} / ${result.total}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  color: QuizColors.navy,
                                ),
                              ),
                              Text(
                                '${(result.accuracy * 100).round()}% Accuracy',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: QuizColors.greenDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.timer_outlined,
                            size: 15, color: QuizColors.greyText),
                        const SizedBox(width: 6),
                        Text(
                          'Completed in ${formatElapsed(result.elapsedSeconds)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: QuizColors.greyText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Breakdown
              _Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Breakdown',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: QuizColors.navy,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: result.passed
                                ? QuizColors.greenSoft
                                : QuizColors.redSoft,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            result.passed
                                ? 'Passed (≥${(kPassAccuracy * 100).round()}%)'
                                : 'Below ${(kPassAccuracy * 100).round()}%',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: result.passed
                                  ? QuizColors.greenDark
                                  : QuizColors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _StatTile(
                          icon: Icons.check,
                          iconColor: QuizColors.green,
                          background: QuizColors.greenSoft,
                          value: '${result.correct}',
                          label: 'Correct',
                        ),
                        const SizedBox(width: 8),
                        _StatTile(
                          icon: Icons.close,
                          iconColor: QuizColors.red,
                          background: QuizColors.redSoft,
                          value: '${result.incorrect}',
                          label: 'Incorrect',
                        ),
                        const SizedBox(width: 8),
                        _StatTile(
                          icon: Icons.remove,
                          iconColor: QuizColors.greyText,
                          background: QuizColors.grey,
                          value: '${result.skipped}',
                          label: 'Skipped',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: QuizColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.speed,
                                  size: 15, color: QuizColors.greyText),
                              const SizedBox(width: 6),
                              Text(
                                'Pace: ${result.paceSeconds}s / question',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: QuizColors.greyText,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            result.paceLabel,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: QuizColors.navy,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              QuizButton(
                label: 'Review Answers',
                onPressed: () => _review(context),
              ),
              const SizedBox(height: 10),
              QuizButton(
                label: 'Try Again',
                leadingIcon: Icons.refresh,
                primary: false,
                onPressed: () => _retry(context),
              ),
              TextButton(
                onPressed: () => _goHome(context),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: QuizColors.navy,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: QuizColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: QuizColors.border),
      ),
      child: child,
    );
  }
}

class _DarkChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DarkChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: QuizColors.navy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: QuizColors.green),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color background;
  final String value;
  final String label;

  const _StatTile({
    required this.icon,
    required this.iconColor,
    required this.background,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 11,
              backgroundColor: iconColor,
              child: Icon(icon, size: 14, color: Colors.white),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: QuizColors.navy,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: QuizColors.greyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

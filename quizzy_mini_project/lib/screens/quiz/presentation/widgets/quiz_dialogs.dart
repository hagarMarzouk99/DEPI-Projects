import 'package:flutter/material.dart';

import '../../quiz_constants.dart';
import '../quiz_colors.dart';
import 'quiz_button.dart';

/// "Submit Your Quiz?" dialog. Returns true if the user chose to submit.
Future<bool> showSubmitDialog(
  BuildContext context, {
  required int answered,
  required int total,
  required int remainingSeconds,
}) async {
  final unanswered = total - answered;
  final submit = await showDialog<bool>(
    context: context,
    builder: (ctx) => _DialogShell(
      icon: Icons.assignment_turned_in_outlined,
      title: 'Submit Your Quiz?',
      message:
          'Are you sure you want to submit your answers and see your result?',
      body: _InfoBox(
        children: [
          if (unanswered > 0) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: QuizColors.orange, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$unanswered of $total questions unanswered',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: QuizColors.navy,
                        ),
                      ),
                      const Text(
                        'Unanswered questions will be scored as 0 points.',
                        style: TextStyle(
                          fontSize: 12,
                          color: QuizColors.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
          ],
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 12,
            runSpacing: 6,
            children: [
              _MiniStat(
                icon: Icons.check_circle_outline,
                text: 'Completed: $answered/$total',
              ),
              _MiniStat(
                icon: Icons.timer_outlined,
                text: 'Time remaining: ${formatClock(remainingSeconds)}',
              ),
            ],
          ),
        ],
      ),
      actions: [
        QuizButton(
          label: 'Submit Quiz',
          trailingIcon: Icons.arrow_forward,
          onPressed: () => Navigator.pop(ctx, true),
        ),
        const SizedBox(height: 10),
        QuizButton(
          label: 'Continue Quiz',
          primary: false,
          onPressed: () => Navigator.pop(ctx, false),
        ),
      ],
    ),
  );
  return submit ?? false;
}

/// "Leave This Quiz?" dialog. Returns true if the user chose to exit.
Future<bool> showLeaveDialog(
  BuildContext context, {
  required int currentQuestion, // 1-based
  required int total,
  required int answered,
}) async {
  final percent = total == 0 ? 0 : (currentQuestion / total * 100).round();
  final exit = await showDialog<bool>(
    context: context,
    builder: (ctx) => _DialogShell(
      icon: Icons.pause_circle_outline,
      title: 'Leave This Quiz?',
      message: 'Your answers are saved automatically. '
          'Would you like to keep playing or exit to categories?',
      body: _InfoBox(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MiniStat(
                icon: Icons.timer_outlined,
                text: 'Question $currentQuestion of $total',
                bold: true,
              ),
              Text(
                '$percent% Done',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: QuizColors.navy,
                ),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$answered answered + ${total - answered} remaining',
                style: const TextStyle(
                  fontSize: 12,
                  color: QuizColors.greyText,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: QuizColors.greenSoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle,
                        size: 14, color: QuizColors.greenDark),
                    SizedBox(width: 4),
                    Text(
                      'Progress saved safely',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: QuizColors.greenDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        QuizButton(
          label: 'Continue Quiz',
          leadingIcon: Icons.play_arrow,
          onPressed: () => Navigator.pop(ctx, false),
        ),
        const SizedBox(height: 10),
        QuizButton(
          label: 'Exit Quiz',
          leadingIcon: Icons.logout,
          primary: false,
          onPressed: () => Navigator.pop(ctx, true),
        ),
        const SizedBox(height: 12),
        const Text(
          'Resume anytime from dashboard',
          style: TextStyle(fontSize: 11, color: QuizColors.greyText),
        ),
      ],
    ),
  );
  return exit ?? false;
}

/// Shared look of both dialogs: close button, icon, title, message, body, actions.
class _DialogShell extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final Widget body;
  final List<Widget> actions;

  const _DialogShell({
    required this.icon,
    required this.title,
    required this.message,
    required this.body,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: QuizColors.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, size: 38, color: QuizColors.navy),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: QuizColors.navy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: QuizColors.greyText),
            ),
            const SizedBox(height: 16),
            body,
            const SizedBox(height: 18),
            ...actions,
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final List<Widget> children;

  const _InfoBox({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: QuizColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: QuizColors.border),
      ),
      child: Column(children: children),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool bold;

  const _MiniStat({required this.icon, required this.text, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: QuizColors.navy),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            color: QuizColors.navy,
          ),
        ),
      ],
    );
  }
}

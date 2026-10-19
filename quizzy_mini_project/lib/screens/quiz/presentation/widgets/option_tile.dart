import 'package:flutter/material.dart';

import '../../data/models/question_model.dart';
import '../quiz_colors.dart';

/// One answer option (A / B / C / D) with a radio indicator on the right.
/// No right/wrong colors here: answers are only checked after submitting.
class OptionTile extends StatelessWidget {
  final String letter;
  final AnswerOption option;
  final bool selected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.letter,
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: selected ? QuizColors.grey : QuizColors.card,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? QuizColors.navy : QuizColors.border,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected ? QuizColors.navy : QuizColors.card,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selected ? QuizColors.navy : QuizColors.border,
                  ),
                ),
                child: Text(
                  letter,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selected ? Colors.white : QuizColors.navy,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: QuizColors.navy,
                      ),
                    ),
                    if (option.subtitle != null)
                      Text(
                        option.subtitle!,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: QuizColors.greyText),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              selected
                  ? Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: QuizColors.navy,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                    )
                  : Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: QuizColors.border, width: 2),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

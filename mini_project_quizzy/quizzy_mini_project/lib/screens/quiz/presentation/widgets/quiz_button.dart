import 'package:flutter/material.dart';

import '../quiz_colors.dart';

/// Full-width rounded button used across the quiz screens.
/// [primary] = navy button, otherwise the soft grey one.
class QuizButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool primary;

  const QuizButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.primary = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: primary ? QuizColors.navy : QuizColors.grey,
          foregroundColor: primary ? Colors.white : QuizColors.navy,
          disabledBackgroundColor: QuizColors.grey,
          disabledForegroundColor: QuizColors.greyText.withValues(alpha: 0.5),
          // Default padding is 24 per side; it made narrow buttons overflow.
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, size: 18),
              const SizedBox(width: 8),
            ],
            // Flexible: if the space is still too small, the text is
            // shortened with "..." instead of overflowing.
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(trailingIcon, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}

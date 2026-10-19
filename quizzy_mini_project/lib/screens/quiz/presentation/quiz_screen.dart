import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/quiz_cubit.dart';
import '../logic/quiz_state.dart';
import '../quiz_constants.dart';
import 'quiz_colors.dart';
import 'results_screen.dart';
import 'widgets/option_tile.dart';
import 'widgets/quiz_button.dart';
import 'widgets/quiz_dialogs.dart';
import 'widgets/timer_pill.dart';

/// Active Quiz Question screen.
///
/// Open it from the Categories / Details screens with:
/// `Navigator.push(context, QuizScreen.route(categoryId: ..., categoryTitle: ...))`
/// It creates its own [QuizCubit], so nobody else needs to provide it.
class QuizScreen extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;
  final String? quizTitle;

  /// Current daily streak, only shown on the results screen when > 0.
  final int streakDays;

  const QuizScreen({
    super.key,
    required this.categoryId,
    required this.categoryTitle,
    this.quizTitle,
    this.streakDays = 0,
  });

  static Route<void> route({
    required String categoryId,
    required String categoryTitle,
    String? quizTitle,
    int streakDays = 0,
  }) {
    return MaterialPageRoute(
      builder: (_) => QuizScreen(
        categoryId: categoryId,
        categoryTitle: categoryTitle,
        quizTitle: quizTitle,
        streakDays: streakDays,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit(
        categoryId: categoryId,
        categoryTitle: categoryTitle,
        quizTitle: quizTitle,
      )..start(),
      child: _QuizView(streakDays: streakDays),
    );
  }
}

class _QuizView extends StatelessWidget {
  final int streakDays;

  const _QuizView({required this.streakDays});

  Future<void> _askLeave(BuildContext context) async {
    final state = context.read<QuizCubit>().state;
    final exit = await showLeaveDialog(
      context,
      currentQuestion: state.currentIndex + 1,
      total: state.total,
      answered: state.answeredCount,
    );
    if (exit && context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizCubit, QuizState>(
      // Runs once: the moment the quiz becomes finished (submit or time over).
      listenWhen: (prev, curr) => !prev.isFinished && curr.isFinished,
      listener: (context, state) {
        final result = context.read<QuizCubit>().result;
        // Close an open dialog first if the time ran out while it was shown.
        Navigator.of(context).popUntil((route) => route is! DialogRoute);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) =>
                ResultsScreen(result: result, streakDays: streakDays),
          ),
        );
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _askLeave(context);
        },
        child: Scaffold(
          backgroundColor: QuizColors.background,
          appBar: AppBar(
            backgroundColor: QuizColors.background,
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              'Active Quiz Question',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: QuizColors.navy,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: QuizColors.navy),
              onPressed: () => _askLeave(context),
            ),
          ),
          body: SafeArea(
            child: BlocBuilder<QuizCubit, QuizState>(
              builder: (context, state) {
                if (!state.isLoaded) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _QuizBody(
                  state: state,
                  onLeave: () => _askLeave(context),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizBody extends StatelessWidget {
  final QuizState state;
  final VoidCallback onLeave;

  const _QuizBody({required this.state, required this.onLeave});

  Future<void> _askSubmit(BuildContext context) async {
    final cubit = context.read<QuizCubit>();
    final submit = await showSubmitDialog(
      context,
      answered: state.answeredCount,
      total: state.total,
      remainingSeconds: state.remainingSeconds,
    );
    if (submit) cubit.submit();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuizCubit>();
    final theme = Theme.of(context);
    final question = state.currentQuestion;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Subject chip + timer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: QuizColors.card,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: QuizColors.border),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.auto_awesome,
                                  size: 14, color: QuizColors.navy),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  question.subject.toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: QuizColors.navy,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      TimerPill(remainingSeconds: state.remainingSeconds),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Question counter + XP chip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Question ${state.currentIndex + 1}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: QuizColors.navy,
                              ),
                            ),
                            TextSpan(
                              text: ' of ${state.total}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: QuizColors.greyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: QuizColors.greenSoft,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bolt,
                                size: 14, color: QuizColors.greenDark),
                            Text(
                              '+$kXpPerCorrect XP',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: QuizColors.greenDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: (state.currentIndex + 1) / state.total,
                      minHeight: 6,
                      color: QuizColors.navy,
                      backgroundColor: QuizColors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Question card
                  Container(
                    decoration: BoxDecoration(
                      color: QuizColors.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: QuizColors.border),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image area (gradient placeholder + topic label)
                        Container(
                          height: 120,
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF2B1B6B), Color(0xFFB4532A)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: question.topic == null
                              ? null
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: QuizColors.navy,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.public,
                                          size: 13, color: Colors.white),
                                      const SizedBox(width: 6),
                                      Text(
                                        question.topic!,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'STANDARD SINGLE CHOICE',
                                style: TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.w800,
                                  color: QuizColors.navy,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                question.text,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: QuizColors.navy,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Select the best answer for this question.',
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
                  ),
                  const SizedBox(height: 16),

                  // Options
                  for (var i = 0; i < question.options.length; i++) ...[
                    OptionTile(
                      letter: String.fromCharCode(65 + i), // A, B, C, D
                      option: question.options[i],
                      selected: state.selectedIndex == i,
                      onTap: () => cubit.selectAnswer(i),
                    ),
                    const SizedBox(height: 10),
                  ],

                  // Auto-save info bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: QuizColors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline,
                            size: 15, color: QuizColors.greyText),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Answer saved automatically. '
                            'You can revisit before submitting.',
                            style: TextStyle(
                              fontSize: 11,
                              color: QuizColors.greyText,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Step ${state.currentIndex + 1}/${state.total}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: QuizColors.navy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Previous / Next (or Submit on the last question)
          Row(
            children: [
              Expanded(
                child: QuizButton(
                  label: 'Previous',
                  leadingIcon: Icons.arrow_back,
                  primary: false,
                  onPressed: state.isFirst ? null : cubit.previous,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: state.isLast
                    ? QuizButton(
                        label: 'Submit Quiz',
                        trailingIcon: Icons.check,
                        onPressed: () => _askSubmit(context),
                      )
                    : QuizButton(
                        label: 'Next Question',
                        trailingIcon: Icons.arrow_forward,
                        onPressed: cubit.next,
                      ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: onLeave,
            icon: const Icon(Icons.pause_circle_outline,
                size: 16, color: QuizColors.greyText),
            label: const Text(
              'Need a break? Pause or leave quiz',
              style: TextStyle(fontSize: 12, color: QuizColors.greyText),
            ),
          ),
        ],
      ),
    );
  }
}

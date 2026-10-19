/// One answer choice. [subtitle] is the small grey line under the title.
class AnswerOption {
  final String title;
  final String? subtitle;

  const AnswerOption(this.title, [this.subtitle]);
}

/// A single-choice question.
class QuestionModel {
  final String text;

  /// Chip at the top-left of the screen, e.g. "PHYSICS & ASTRONOMY".
  final String subject;

  /// Small label on the question image, e.g. "Solar System" (optional).
  final String? topic;

  final List<AnswerOption> options;

  /// Index (inside [options]) of the correct answer.
  final int correctIndex;

  const QuestionModel({
    required this.text,
    required this.subject,
    this.topic,
    required this.options,
    required this.correctIndex,
  });
}

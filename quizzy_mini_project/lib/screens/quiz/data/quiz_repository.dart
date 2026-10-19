import 'models/question_model.dart';

/// Local (offline) source of questions, keyed by category id.
///
/// There is no backend, so questions live here. If the category id sent from
/// the Categories screen is unknown we fall back to "general" so the quiz
/// never opens empty.
class QuizRepository {
  List<QuestionModel> getQuestions(String categoryId) {
    return _bank[categoryId] ?? _bank['general']!;
  }

  static List<AnswerOption> _o(List<String> titles) =>
      titles.map((t) => AnswerOption(t)).toList();

  static final Map<String, List<QuestionModel>> _bank = {
    'science': [
      QuestionModel(
        text: 'Which planet is known as the Red Planet?',
        subject: 'Physics & Astronomy',
        topic: 'Solar System',
        options: const [
          AnswerOption('Venus', 'Second rock from the Sun'),
          AnswerOption('Mars', 'Fourth terrestrial planet'),
          AnswerOption('Jupiter', 'Largest gas giant'),
          AnswerOption('Mercury', 'Closest orbiter to the Sun'),
        ],
        correctIndex: 1,
      ),
      QuestionModel(
        text: 'What is the chemical formula of water?',
        subject: 'Chemistry',
        topic: 'Basic Elements',
        options: _o(['CO2', 'H2O', 'O2', 'NaCl']),
        correctIndex: 1,
      ),
      QuestionModel(
        text: 'Which gas do plants absorb from the air for photosynthesis?',
        subject: 'Biology',
        topic: 'Living Cells',
        options: _o(['Oxygen', 'Nitrogen', 'Carbon dioxide', 'Hydrogen']),
        correctIndex: 2,
      ),
      QuestionModel(
        text: 'What is the hardest natural substance on Earth?',
        subject: 'Chemistry',
        topic: 'Matter',
        options: _o(['Gold', 'Iron', 'Quartz', 'Diamond']),
        correctIndex: 3,
      ),
      QuestionModel(
        text: 'How many bones are in the adult human body?',
        subject: 'Biology',
        topic: 'Human Body',
        options: _o(['106', '206', '306', '156']),
        correctIndex: 1,
      ),
    ],
    'flutter': [
      QuestionModel(
        text: 'Which method is used inside a Cubit to update the state?',
        subject: 'Flutter',
        topic: 'State Management',
        options: _o(['setState()', 'emit()', 'notify()', 'update()']),
        correctIndex: 1,
      ),
      QuestionModel(
        text: 'Which widget rebuilds the UI when the Cubit state changes?',
        subject: 'Flutter',
        topic: 'State Management',
        options: _o([
          'BlocProvider',
          'BlocListener',
          'BlocBuilder',
          'RepositoryProvider',
        ]),
        correctIndex: 2,
      ),
      QuestionModel(
        text: 'What is BlocProvider used for?',
        subject: 'Flutter',
        topic: 'State Management',
        options: _o([
          'Drawing animations',
          'Providing a Cubit to its widget subtree',
          'Saving data locally',
          'Calling an API',
        ]),
        correctIndex: 1,
      ),
      QuestionModel(
        text: 'Which widget is best for one-time actions like navigation '
            'when the state changes?',
        subject: 'Flutter',
        topic: 'State Management',
        options: _o([
          'BlocBuilder',
          'Container',
          'BlocListener',
          'FutureBuilder',
        ]),
        correctIndex: 2,
      ),
      QuestionModel(
        text: 'What is the main difference between Cubit and Bloc?',
        subject: 'Flutter',
        topic: 'State Management',
        options: _o([
          'Cubit uses functions, Bloc uses events',
          'Cubit is faster on Android only',
          'Bloc cannot emit states',
          'There is no difference',
        ]),
        correctIndex: 0,
      ),
    ],
    'general': [
      QuestionModel(
        text: 'What is the capital of Egypt?',
        subject: 'Geography',
        topic: 'Countries',
        options: _o(['Alexandria', 'Giza', 'Cairo', 'Luxor']),
        correctIndex: 2,
      ),
      QuestionModel(
        text: 'Which is the largest ocean on Earth?',
        subject: 'Geography',
        topic: 'Oceans',
        options: _o(['Atlantic', 'Pacific', 'Indian', 'Arctic']),
        correctIndex: 1,
      ),
      QuestionModel(
        text: 'How many continents are there?',
        subject: 'Geography',
        topic: 'World',
        options: _o(['5', '6', '7', '8']),
        correctIndex: 2,
      ),
      QuestionModel(
        text: 'Who painted the Mona Lisa?',
        subject: 'Art & History',
        topic: 'Famous Artists',
        options: _o(['Picasso', 'Van Gogh', 'Da Vinci', 'Michelangelo']),
        correctIndex: 2,
      ),
      QuestionModel(
        text: 'What is the currency of Japan?',
        subject: 'Economics',
        topic: 'Currencies',
        options: _o(['Won', 'Yuan', 'Yen', 'Ringgit']),
        correctIndex: 2,
      ),
    ],
  };
}

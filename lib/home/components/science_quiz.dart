
class ComputerQuiz{
  final String category;
  final String type;
  final String difficulty;
  late final String question;
  final String correctAnswer;
  final List<dynamic> incorrectAnswer;

  ComputerQuiz({
    required this.category,
     required this.type,
      required this.difficulty,
    required this.question,
     required this.correctAnswer,
      required this.incorrectAnswer,
    });
}


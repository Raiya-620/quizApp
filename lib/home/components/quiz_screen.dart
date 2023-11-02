import 'package:flutter/material.dart';
import 'quiz_question.dart';

class QuizQuestionWidget extends StatefulWidget {
  final String username;
  final List<Question> questions;
  final Function(int) onQuizCompleted;

  QuizQuestionWidget({required this.username, required this.questions, required this.onQuizCompleted});

  @override
  _QuizQuestionWidgetState createState() => _QuizQuestionWidgetState();
}

class _QuizQuestionWidgetState extends State<QuizQuestionWidget> {
  int currentQuestionIndex = 0;
  String? selectedOption;
  bool showNextButton = false;

  void showNextQuestion() {
    setState(() {
      if (currentQuestionIndex < widget.questions.length - 1) {
        currentQuestionIndex++;
        selectedOption = null;
        showNextButton = false;
      } else {
        int score = widget.questions.where((question) => question.correctAnswer == selectedOption).length;
        widget.onQuizCompleted(score);
      }
    });
  }

  void checkAnswer() {
    setState(() {
      if (selectedOption == widget.questions[currentQuestionIndex].correctAnswer) {
        // Handle correct answer logic here
      } else {
        // Handle incorrect answer logic here
      }

      if (currentQuestionIndex < widget.questions.length - 1) {
        showNextButton = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentQuestionIndex];
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(currentQuestion.question),
            ...currentQuestion.options.map((option) {
              return RadioListTile(
                title: Text(option),
                value: option,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                    showNextButton = true;
                  });
                },
              );
            }).toList(),
            ElevatedButton(
              onPressed: () {
                if (selectedOption != null) {
                  checkAnswer();
                  showNextQuestion();
                }
              },
              child: Text('Submit Answer'),
            ),
            if (showNextButton)
              ElevatedButton(
                onPressed: () {
                  showNextQuestion();
                },
                child: Text('Next Question'),
              ),
          ],
        ),
      ),
    );
  }
}



class QuizScreen extends StatelessWidget {
  final String username;
  final List<Question> questions;
  final Function(int) onQuizCompleted;

  QuizScreen({required this.username, required this.questions, required this.onQuizCompleted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Questions'),
      ),
      body: QuizQuestionWidget(
        username: username,
        questions: questions,
        onQuizCompleted: onQuizCompleted,
      ),
    );
  }
}

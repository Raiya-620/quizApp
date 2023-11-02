
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

// class Answer{
//   final  String answerText;
//   late final bool iscorrect;

//   Answer (this.answerText,this.iscorrect);
// }




Future<List<Question>> fetchQuestions() async {
  final response = await http.get(
    Uri.parse('https://opentdb.com/api.php?amount=10&type=multiple'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(data['results']);

    return results.map((questionData) {
      List<String> options = List<String>.from(questionData['incorrect_answers']);
      options.add(questionData['correct_answer']);
      return Question(
        question: questionData['question'],
        options: options,
        correctAnswer: questionData['correct_answer'],
      );
    }).toList();
  } else {
    throw Exception('Failed to load trivia questions');
  }
}


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

  
  
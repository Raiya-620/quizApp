import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Trivia Questions'),
        ),
        body: const TriviaList(),
      ),
    );
  }
}

class TriviaList extends StatefulWidget {
  const TriviaList({super.key});

  @override
  _TriviaListState createState() => _TriviaListState();
}

class _TriviaListState extends State<TriviaList> {
  List<TriviaQuestion> questions = [];

  @override
  void initState() {
    super.initState();
    fetchTriviaQuestions().then((data) {
      setState(() {
        questions = data;
      });
    });
  }

  Future<List<TriviaQuestion>> fetchTriviaQuestions() async {
    final response = await http.get(
      Uri.parse('https://opentdb.com/api.php?amount=10&type=multiple'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> rawData = json.decode(response.body)['results'];
      return rawData.map((data) => TriviaQuestion.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load trivia questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(questions[index].question),
          subtitle: Column(
            children: questions[index].options.map((option) {
              return Text(option);
            }).toList(),
          ),
        );
      },
    );
  }
}

class TriviaQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;

  TriviaQuestion({required this.question, required this.options, required this.correctAnswer});

  factory TriviaQuestion.fromJson(Map<String, dynamic> json) {
    return TriviaQuestion(
      question: json['question'],
      options: List<String>.from(json['incorrect_answers'])..add(json['correct_answer']),
      correctAnswer: json['correct_answer'],
    );
  }
}

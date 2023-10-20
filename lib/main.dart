import 'dart:convert';
import 'package:flutter/material.dart';


//  import 'package:quiz_app/quiz_screen..dart';
 import 'package:http/http.dart' as http;
import 'package:quiz_app/home/components/quiz_model.dart';
import 'package:quiz_app/home/components/quiz_question_widget.dart';


void main(){
  runApp(
    const MyApp()
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizApp(),
    );
  }
}
 class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<QuizQuestion>questions=[];
   @override
  void initState() {
    super.initState();
      fetchQuizQuestions().then((quizQuestions){
        setState(() {
          questions=quizQuestions;
        });
      });
  }
 
   Future<List<QuizQuestion>>
  fetchQuizQuestions()
   async {
    final response = await
    http.get(Uri.parse('https://opentdb.com/api.php?amount=10&category=18&type=multiple')
    );
    if(response.statusCode==200){
      final List<dynamic> jsonList = json.decode(response.body)['results'];
     return jsonList.map((json)=>QuizQuestion(
      category: json['category'],
      question: json['question'],
     )).toList();
    }else{
      throw Exception('Failed to load questions');
    }
  }


  
  // final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueAccent[700],
      body:Stack(
              children: [
                Container(
                color: Colors.indigo[900],
                child: Center(
                  child: GridView.count(
                    crossAxisCount: 6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 8,
                    padding: const EdgeInsets.all(16),
                    children: List.generate(66,
                     (index) =>  Text('?',
                     style: TextStyle(
                      color: Colors.lightBlue[900],
                      fontSize: 24
                     ),
                     )
                     ),
                  ),
                ),
                  ),
                Column(
               crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   const SizedBox(height: 200),
                   const Text('Let\'s Play Quiz,',
                   style: TextStyle(
                     fontSize: 60,
                     color: Colors.white
                   ),
                   ),
                   const SizedBox(height: 10),
                   const Text('Enter your information below',
                   style: TextStyle(
                     fontSize: 20,
                     color: Colors.white
                   ),
                   ),
                   const SizedBox(height: 50),
                   const SizedBox(
                     width: double.infinity,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.name,
                      enabled: true,
                      decoration: InputDecoration(
                        filled: true,
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                          color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3,
                          color: Colors.white,)
                          ),
                      ),
                    ),
                  ),
                    const SizedBox(height: 100),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                      MaterialPageRoute(
                            builder:(context)=>const QuizQuestionWidget() )
                        );
                      },
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(20),
                        ),
                            child: const Text('Let\'s start quiz'),
                      ),
                  ),
                          ],
              ),
              ],
      ),
    );
    }
  }

import 'dart:convert';
 import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:quiz_app/home/components/quiz_model.dart';

class QuizQuestionWidget extends StatelessWidget {
  const QuizQuestionWidget({super.key});
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

        @override
        Widget build(BuildContext context) {
          return 
          FutureBuilder<List<QuizQuestion>>(
            future: fetchQuizQuestions(),
            builder:(context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(
                  child:CircularProgressIndicator(),
                );
              }else if(snapshot.hasError){
                return Center(
                  child:Text('Error:${snapshot.error}'),
                );
              }else{
                final List<QuizQuestion>
                questions=snapshot.data!;
                return ListView.builder(
                  itemCount:questions.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title:Text(questions[index].question),
                      subtitle:Text(questions[index].category)
                    );
                  });
              }
            }
          )
          ;
        } 
      }

      
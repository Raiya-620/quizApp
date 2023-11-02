import 'dart:convert';
 import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quiz_app/home/components/option_tile.dart';
import 'package:quiz_app/home/components/science_quiz.dart';

class ScienceAndComputer extends StatefulWidget {
  const ScienceAndComputer({super.key});

  @override
  State<ScienceAndComputer> createState() => _ScienceAndComputerState();
}

class _ScienceAndComputerState extends State<ScienceAndComputer> {
  bool isLoading=true;
  int quizNumber=0;
  int score=0;
  List<ComputerQuiz> computerQuizzes=[];
  List <String>possibleAnswers=[];

 Future<void>fetchQuizQuestion()async{
  var response=await http.get(Uri.https('opentdb.com','api.php',{
    'amount':'10',
    'category':'18',
  }));
  var jsonData=jsonDecode(response.body);

   for(var everylist in jsonData['results']){
      final quiz = ComputerQuiz(
        category:everylist['category'],
        type:everylist['type'],
        difficulty:everylist['difficulty'],
        question:everylist['question'],
        correctAnswer:everylist['correct_answer'],
        incorrectAnswer:everylist['incorrect_answers']
      );
      computerQuizzes.add(quiz); 
     }

     for(var everyQuiz in computerQuizzes){
      String theQuestion=everyQuiz.question;
      HtmlUnescape htmlUnescape=HtmlUnescape();
      everyQuiz.question=htmlUnescape.convert(theQuestion);
     }

     setState(() {
       isLoading=false;
     }); 

     _getAndShuffleAnswer();

 }

 int _getNumOptions(){
  if(computerQuizzes[quizNumber].type=='multiple'){
    return 4;
  }else{
    return 2;
  }
 }

 void _getAndShuffleAnswer(){
  possibleAnswers.add(computerQuizzes[quizNumber].correctAnswer);
  for(var incorrectAnswer in computerQuizzes[quizNumber].incorrectAnswer){
    possibleAnswers.add(incorrectAnswer);
  }
  possibleAnswers.shuffle();
 }

  void _nextQuestion(){
    setState(() {
      quizNumber++;
      possibleAnswers.clear();
      _getAndShuffleAnswer();
    });
  }
 @override
  void initState() {
    fetchQuizQuestion();
    super.initState();
  }

    
        @override
        Widget build(BuildContext context) {
          return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueAccent[700],
      body:
      isLoading?const Center(child: CircularProgressIndicator()) :
      Column(
              children: [
                Container(
                  height: 150,
                decoration: const BoxDecoration(
                  color: Colors.blue
                ),
                child:Center(
                  child:Text(
                    maxLines:null,
                    softWrap: true,
                    computerQuizzes[quizNumber].question,
                    style:const TextStyle(fontSize: 13)
                  )
                )
                     ),
                     Expanded(
                      child: ListView.builder(
                        itemCount: _getNumOptions(),
                        itemBuilder:(context,index){
                          return OptionTile(
                            probableAnswer:possibleAnswers[index],
                            onTap:(){
                              if( possibleAnswers[index]==computerQuizzes[quizNumber].correctAnswer){
                                _nextQuestion();
                                score++;
                                // print('Current_score $(score)/$(quizNumber)');
                              }
                              else{
                                _nextQuestion();
                                // print('Current_score $(score)/$(quizNumber)')
                              }
                            }
                          );
                        } ))
                     ]
                     )
                     );
}
}
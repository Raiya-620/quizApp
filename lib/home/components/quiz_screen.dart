import 'package:flutter/material.dart';
import 'package:quiz_app/home/components/quiz_question.dart';



class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  List<Question>questionList=getQuestion();
  int currentQuestionIndex=0;
  int score=0;
  Answer?selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.blueAccent[700],
      body:
      Stack(
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
           _questionWidget(),
            _answerList(),
            _nextButton()
        ],
      )
              ]
      )
      );
  }

  _questionWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30,),
        Text(
          "Question ${currentQuestionIndex +1}/${questionList.length.toString()}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),
        ),
        const SizedBox(height: 50,),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16)
          ),
          child:  Text(
            questionList[currentQuestionIndex].questionText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
          ),
        )
      ],
    );
  }
  _answerList(){
    return Column(
      children: questionList[currentQuestionIndex].answerList.map(
        (e) => _answerButton(e)
        )
        .toList(),

    );
  }

 Widget _answerButton(Answer answer){

  bool isSelected=answer==selectedAnswer;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48, 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
           primary:isSelected?Colors.green:Colors.white,
            onPrimary:isSelected?Colors.white:Colors.black,
        ),
        onPressed: (){
             if(selectedAnswer==null){
              if(answer.iscorrect){
                score++;
              }
               setState(() {
            selectedAnswer=answer;
          });
             }
        },
        child: Text(answer.answerText),
      ),
    );
  }
    _nextButton(){
      bool isLastQuestion=false;
      if(currentQuestionIndex==questionList.length-1){
        isLastQuestion=true;
      }



      return SizedBox(
      width: MediaQuery.of(context).size.width*0.5,
      height: 48, 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
           primary:Colors.blueAccent,
            onPrimary:Colors.white,
        ),
        onPressed: (){
            if(isLastQuestion){
              //display score
            showDialog(context: context, 
            builder: (_)=>_showScoreDialog());
            }else{
              //next question
              setState(() {
                selectedAnswer=null;
                currentQuestionIndex++;
              });
            }
        },
         child: Text( isLastQuestion?"Submit":"Next"),
      ),
    );
    }
    _showScoreDialog(){
      bool isPassed=false;

       if(score>=questionList.length*0.6){
        //pass if 60%
        isPassed=true;
       }
        String title=isPassed?"Passed":"Failed";

      return AlertDialog(
        title: Text( title+"|Score is $score",
        style: TextStyle(
          color: isPassed?Colors.green:Colors.redAccent
        ),
        ),
        content: ElevatedButton(
          child: const Text("Restart"),
          onPressed:(){
            Navigator.pop(context);
            setState(() {
              currentQuestionIndex=0;
            score=0;
            selectedAnswer=null;
            });
          } ,),
      );
    }
}
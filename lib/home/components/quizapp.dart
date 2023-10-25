
import 'package:flutter/material.dart';
import 'package:quiz_app/home/components/science_computers.dart';

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {


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
                      keyboardType: TextInputType.text,
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
                            builder:(context)=>const ScienceAndComputer() )
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

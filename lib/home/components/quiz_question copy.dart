class Question{
  final String questionText;
  late final List<Answer>answerList;

  Question(this.questionText,this.answerList);
}

class Answer{
  final  String answerText;
  late final bool iscorrect;

  Answer (this.answerText,this.iscorrect);
}

List<Question>getQuestion(){
  List<Question>list=[];

  list.add(
    Question("Who is the owner of Flutter?",[
      Answer("Nokia", false),
       Answer("Samsung", false),
        Answer("Google", true),
         Answer("Apple", false),
    ]),);
    list.add(
    Question("What command would you run to verify your flutter install and ensure your environment is set up correctly?",[
      Answer("Flutter run", false),
       Answer("Flutter build", false),
        Answer("Flutter doctor", true),
         Answer("Flutter help", false),
    ]),);
    list.add(
    Question("What language is Flutters rendering engine primarily written in?",[
      Answer("Kotlin", false),
       Answer("C++", true),
        Answer("Dart", false),
         Answer("Java", false),
    ]),);
    list.add(
    Question("Flutter uses dart as a language?",[
      Answer("True", true),
       Answer("False", false),
    ]),);
    list.add(
    Question("How many types of widgets are there in flutter?",[
      Answer("2", true),
       Answer("4", false),
        Answer("6", false),
         Answer("8+", false),
    ]),);
    list.add(
    Question("When building for iOS,Flutter is restricted to an --------- compilation strategy",[
      Answer("AOT(ahead-of-time)", true),
       Answer("JIT(just-in-time)", false),
        Answer("Transcompilation", false),
         Answer("Recompilation", false),
    ]),);
    list.add(
    Question("Flutter boast improved runtime performance over most application frameworks?",[
      Answer("true", true),
       Answer("false", false),
    ]),);
    list.add(
    Question("What is the key configuration file used when building a flutter project?",[
      Answer("pubspec.yaml", true),
       Answer("pubspec.xml", false),
        Answer("config.html", false),
         Answer("root.xml", false),
    ]),);
    list.add(
    Question("Which component allows us to specify the distance between widgets on the screen?",[
      Answer("SafeArea", false),
       Answer("Sizedbox", true),
        Answer("table", false),
         Answer("AppBar", false),
    ]),);
    list.add(
    Question("Which widget type allows you to modify its appearance dynamically according to user input?",[
      Answer("Stateful widget", true),
       Answer("Stateless widget", false),
    ]),);
  return list;
}
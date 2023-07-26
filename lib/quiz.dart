import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/quesetion_screen.dart';
import 'package:quiz_app/result_screen.dart';
import 'package:quiz_app/start_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var activeScreen = 'start-screen';
  final List<String> selectedAnswers = [];

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void resetQuiz() {
    while (selectedAnswers.isNotEmpty) {
      selectedAnswers.removeLast();
    }
    setState(() {
      activeScreen = 'start-screen';
    });
  }

  void chooseAnswer(String ans) {
    if (selectedAnswers.length < questions.length) {
      selectedAnswers.add(ans);
    } else {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen == 'start-screen'
              ? StartScreen(switchScreen)
              : activeScreen == 'result-screen'
                  ? ResultScreen(
                      reset: resetQuiz,
                      selectedAnswers: selectedAnswers,
                    )
                  : QuestionScreen(
                      chooseAnswer: chooseAnswer,
                    ),
        ),
      ),
    );
  }
}

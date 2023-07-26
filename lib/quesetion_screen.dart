import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'data/questions.dart';

class QuestionScreen extends StatefulWidget {
  final void Function(String) chooseAnswer;
  const QuestionScreen({required this.chooseAnswer, super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currQuesIndex = 0;

  void pickAnswer(String selectedAnswer) {
    widget.chooseAnswer(selectedAnswer);
    if (currQuesIndex < questions.length - 1) {
      setState(() {
        currQuesIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currQuesIndex];

    return Center(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                currentQuestion.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ...currentQuestion.getShuffledAnswers().map(
                (e) {
                  return AnswerButton(
                    cb: () {
                      pickAnswer(e);
                    },
                    text: e,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

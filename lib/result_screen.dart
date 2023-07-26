import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/question_summary.dart';

class ResultScreen extends StatelessWidget {
  final void Function() reset;
  final List<String> selectedAnswers;
  const ResultScreen({
    required this.selectedAnswers,
    required this.reset,
    super.key,
  });

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': selectedAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((e) {
          return e['user_answer'] == e['correct_answer'];
        })
        .toList()
        .length;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You have answered $numCorrectQuestions out of $numTotalQuestions",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 30),
          QuestionSummary(summaryData),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              reset();
            },
            label: const Text("Reset Quiz"),
            icon: const Icon(Icons.restart_alt),
          )
        ],
      ),
    );
  }
}

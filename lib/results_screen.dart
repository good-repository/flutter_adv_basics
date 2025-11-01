import 'package:flutter/material.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.restartQuiz,
    required this.selectedAnswers,
  });

  final VoidCallback restartQuiz;
  final List<String> selectedAnswers;

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
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          QuestionsSummary(summaryData: summaryData),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: restartQuiz,
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.refresh),
            label: const Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}

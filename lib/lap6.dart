import 'package:flutter/material.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        body: SafeArea(child: QuizPage()),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<String> questions = [
    'Mặt trời mọc ở hướng Đông?',
    'Flutter do Apple phát triển?',
    'Số 2 là số nguyên tố?',
  ];
  List<bool> answers = [true, false, true];
  int questionNumber = 0;

  void checkAnswer(bool userPicked) {
    setState(() {
      if (questionNumber < questions.length - 1) {
        questionNumber++;
      } else {
        questionNumber = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              questions[questionNumber],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25.0, color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () => checkAnswer(true),
              child: const Text('Đúng', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => checkAnswer(false),
              child: const Text('Sai', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
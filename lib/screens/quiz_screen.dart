import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  static const routeName = '/quiz';

  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adaptive Quiz')),
      body: const Center(
        child: Text(
          'Quiz placeholder - hook up AdaptiveEngine here.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
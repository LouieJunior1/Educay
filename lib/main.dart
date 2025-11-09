import 'package:flutter/material.dart';

void main() {
  runApp(const EducayApp());
}

class EducayApp extends StatelessWidget {
  const EducayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Educay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educay'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Educay 👋',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Start Adaptive Quiz'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('View Progress'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Teacher Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}


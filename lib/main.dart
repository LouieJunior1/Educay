import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/quiz_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/teacher_dashboard_screen.dart';
import 'services/students_services.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => StudentService(),
      child: const EducayApp(),
    ),
  );
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
      routes: {
        '/': (context) => const HomeScreen(),
        QuizScreen.routeName: (context) => const QuizScreen(),
        ProgressScreen.routeName: (context) => const ProgressScreen(),
        TeacherDashboardScreen.routeName: (context) =>
            const TeacherDashboardScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Educay')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, QuizScreen.routeName);
              },
              child: const Text('Start Adaptive Quiz'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ProgressScreen.routeName);
              },
              child: const Text('View Progress'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, TeacherDashboardScreen.routeName);
              },
              child: const Text('Teacher Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/student_service.dart';
import '../models/student.dart';

class TeacherDashboardScreen extends StatelessWidget {
  static const routeName = '/teacher';

  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentService = context.watch<StudentService>();
    final students = studentService.students;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, i) {
          final s = students[i];
          return ListTile(
            title: Text(s.name),
            subtitle: Text(
              'Status: ${s.homeworkScore > 80 ? "Excellent" : s.homeworkScore > 60 ? "Good" : "Needs Improvement"}'
              '${s.note != null && s.note!.isNotEmpty ? '\nNote: ${s.note}' : ''}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                _showUpdateDialog(context, s, studentService);
              },
            ),
          );
        },
      ),
    );
  }

  void _showUpdateDialog(
    BuildContext context,
    Student student,
    StudentService studentService,
  ) {
    final scoreController =
        TextEditingController(text: student.homeworkScore.toString());
    final noteController = TextEditingController(text: student.note ?? '');

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Update ${student.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: scoreController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration:
                    const InputDecoration(labelText: 'Homework Score'),
              ),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(labelText: 'In-class Note'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newScore = double.tryParse(scoreController.text);
                if (newScore != null) {
                  studentService.updateHomework(student.id, newScore);
                }
                studentService.updateNote(student.id, noteController.text);
                Navigator.of(ctx).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
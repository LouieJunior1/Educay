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
      appBar: AppBar(title: const Text('Teacher Dashboard')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: students.length,
        itemBuilder: (context, i) {
          final Student s = students[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(s.name),
              subtitle: Text(
                'Status: ${s.performanceLabel}'
                '${s.note.isNotEmpty ? '\nNote: ${s.note}' : ''}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showUpdateDialog(context, s);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, Student student) {
    final scoreController =
        TextEditingController(text: student.homeworkScore.toStringAsFixed(0));
    final noteController = TextEditingController(text: student.note);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Update ${student.name}'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: scoreController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Homework score (0-100)',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: noteController,
                  decoration: const InputDecoration(
                    labelText: 'In-class note',
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newScore = double.tryParse(scoreController.text) ?? 0;
                context
                    .read<StudentService>()
                    .updateHomework(student.id, newScore);
                context
                    .read<StudentService>()
                    .updateNote(student.id, noteController.text.trim());
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
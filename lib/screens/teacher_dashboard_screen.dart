import 'package:flutter/material.dart';
import '../services/student_service.dart';
import '../models/student.dart';

class TeacherDashboardScreen extends StatelessWidget {
  static const routeName = '/teacher';

  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // we’ll pass the service in from main.dart for now
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Dashboard'),
      ),
      body: _TeacherDashboardBody(),
    );
  }
}

class _TeacherDashboardBody extends StatefulWidget {
  @override
  State<_TeacherDashboardBody> createState() => _TeacherDashboardBodyState();
}

class _TeacherDashboardBodyState extends State<_TeacherDashboardBody> {
  // temporary local service – in a “real” app this would come from Provider
  final StudentService _studentService = StudentService();

  @override
  Widget build(BuildContext context) {
    final students = _studentService.students;

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, i) {
        final Student s = students[i];

        // work out a text label from homeworkScore
        final String status = s.homeworkScore > 80
            ? 'Excellent'
            : s.homeworkScore > 60
                ? 'Good'
                : 'Needs improvement';

        return ListTile(
          title: Text(s.name),
          subtitle: Text(
            'Status: $status'
            '${s.note != null && s.note!.isNotEmpty ? '\nNote: ${s.note}' : ''}',
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showUpdateDialog(context, s);
            },
          ),
        );
      },
    );
  }

  void _showUpdateDialog(BuildContext context, Student student) {
    final scoreController =
        TextEditingController(text: student.homeworkScore.toString());
    final noteController = TextEditingController(text: student.note ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update ${student.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: scoreController,
                decoration: const InputDecoration(
                  labelText: 'Homework score (0–100)',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: 'In-class note',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final parsed = double.tryParse(scoreController.text) ?? 0;
                _studentService.updateHomework(student.id, parsed);
                _studentService.updateNote(student.id, noteController.text);
                setState(() {}); // refresh list
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
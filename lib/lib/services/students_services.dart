// lib/services/student_service.dart
import 'package:flutter/foundation.dart';
import '../models/student.dart';

class StudentService extends ChangeNotifier {
  final List<Student> _students = [
    Student(id: '1', name: 'Alice', homeworkScore: 52),
    Student(id: '2', name: 'Ben', homeworkScore: 88),
    Student(id: '3', name: 'Cara', homeworkScore: 71),
  ];

  List<Student> get students => List.unmodifiable(_students);

  // teacher updates homework score from class / homework
  void updateHomework(String id, double newScore) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index == -1) return;
    _students[index] = _students[index].copyWith(homeworkScore: newScore);
    notifyListeners();
  }

  // teacher adds an in-class note
  void updateNote(String id, String note) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index == -1) return;
    _students[index] = _students[index].copyWith(note: note);
    notifyListeners();
  }
}
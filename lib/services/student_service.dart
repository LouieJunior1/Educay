// lib/services/student_service.dart
import '../models/student.dart';

class StudentService {
  final List<Student> _students = [
    Student(id: '1', name: 'Alice', homeworkScore: 52),
    Student(id: '2', name: 'Ben', homeworkScore: 88),
    Student(id: '3', name: 'Cara', homeworkScore: 71),
  ];

  // track streaks of perfect homework
  final Map<String, int> _perfectStreaks = {}; // studentId -> count

  // alerts for parents
  final List<String> _parentAlerts = [];

  List<Student> get students => List.unmodifiable(_students);
  List<String> get parentAlerts => List.unmodifiable(_parentAlerts);

  // student finished homework/quiz
  void recordHomeworkResult(String id, double scorePercent) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index == -1) return;

    final current = _students[index];

    // average old + new
    final newScore = (current.homeworkScore + scorePercent) / 2;
    _students[index] = current.copyWith(homeworkScore: newScore);

    // handle streaks
    if (scorePercent >= 100) {
      _perfectStreaks[id] = (_perfectStreaks[id] ?? 0) + 1;
    } else {
      _perfectStreaks[id] = 0;
    }

    // after 3 perfects -> alert parent
    if ((_perfectStreaks[id] ?? 0) >= 3) {
      _parentAlerts.add('${current.name} is consistently excelling in homework.');
    }
  }

  // teacher in-class praise
  void teacherPraised(String id, {String note = 'Doing very well in class'}) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index == -1) return;

    final student = _students[index];
    _students[index] = student.copyWith(note: note);

    _parentAlerts.add('${student.name} is doing very well in class.');
  }

  // teacher manual adjust
  void updateHomework(String id, double newScore) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index == -1) return;
    _students[index] = _students[index].copyWith(homeworkScore: newScore);
  }

  void updateNote(String id, String note) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index == -1) return;
    _students[index] = _students[index].copyWith(note: note);
  }
}


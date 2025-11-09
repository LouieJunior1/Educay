// lib/models/student.dart
class Student {
  final String id;
  final String name;
  final double homeworkScore; // 0–100
  final String note; // teacher note

  Student({
    required this.id,
    required this.name,
    required this.homeworkScore,
    this.note = '',
  });

  // work out how they're doing
  String get performanceLabel {
    if (homeworkScore >= 85) return 'excelling';
    if (homeworkScore >= 60) return 'on track';
    return 'struggling';
  }

  Student copyWith({
    double? homeworkScore,
    String? note,
  }) {
    return Student(
      id: id,
      name: name,
      homeworkScore: homeworkScore ?? this.homeworkScore,
      note: note ?? this.note,
    );
  }
}

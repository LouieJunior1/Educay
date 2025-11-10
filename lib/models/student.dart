class Student {
  final String id;
  final String name;
  final double homeworkScore;
  final String? note;

  Student({
    required this.id,
    required this.name,
    required this.homeworkScore,
    this.note,
  });
class Student {
  final String id;
  final String name;
  final double homeworkScore;
  final String? note;

  Student({
    required this.id,
    required this.name,
    required this.homeworkScore,
    this.note,
  });

  
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      homeworkScore: homeworkScore ?? this.homeworkScore,
      note: note ?? this.note,
    );
  }
}
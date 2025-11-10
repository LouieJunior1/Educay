class Student {
  final String id;
  final String name;
  double homeworkScore;
  String note;

  Student({
    required this.id,
    required this.name,
    this.homeworkScore = 0,
    this.note = '',
  });

  String get performanceLabel {
    if (homeworkScore >= 85) return 'excelling';
    if (homeworkScore >= 60) return 'on track';
    return 'struggling';
  }
}

enum Mastery {
  weak,
  developing,
  secure,
  mastered,
}

class TopicProgress {
  final String subjectId;
  final String topicId;
  final int totalAnswered;
  final int totalCorrect;
  final int correctStreak;
  final int wrongStreak;
  final int difficulty; // 0 easy, 1 medium, 2 hard
  final Mastery mastery;

  TopicProgress({
    required this.subjectId,
    required this.topicId,
    this.totalAnswered = 0,
    this.totalCorrect = 0,
    this.correctStreak = 0,
    this.wrongStreak = 0,
    this.difficulty = 0,
    this.mastery = Mastery.weak,
  });

  double get accuracy =>
      totalAnswered == 0 ? 0 : totalCorrect / totalAnswered;

  TopicProgress copyWith({
    int? totalAnswered,
    int? totalCorrect,
    int? correctStreak,
    int? wrongStreak,
    int? difficulty,
    Mastery? mastery,
  }) {
    return TopicProgress(
      subjectId: subjectId,
      topicId: topicId,
      totalAnswered: totalAnswered ?? this.totalAnswered,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      correctStreak: correctStreak ?? this.correctStreak,
      wrongStreak: wrongStreak ?? this.wrongStreak,
      difficulty: difficulty ?? this.difficulty,
      mastery: mastery ?? this.mastery,
    );
  }

  static Mastery calculateMastery(TopicProgress p) {
    if (p.totalAnswered >= 20 && p.accuracy >= 0.85) return Mastery.mastered;
    if (p.totalAnswered >= 12 && p.accuracy >= 0.7) return Mastery.secure;
    if (p.totalAnswered >= 6 && p.accuracy >= 0.5) return Mastery.developing;
    return Mastery.weak;
  }
}
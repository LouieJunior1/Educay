import 'package:flutter/foundation.dart';
import '../models/progress.dart';
import 'curriculum_service.dart';

class AdaptiveEngine extends ChangeNotifier {
  final CurriculumService curriculum;

  String subjectId = 'maths';
  String topicId = 'fractions';

  TopicProgress progress = TopicProgress(
    subjectId: 'maths',
    topicId: 'fractions',
  );

  Question? currentQuestion;

  AdaptiveEngine({required this.curriculum}) {
    _loadQuestion();
  }

  void setPath(String subject, String topic) {
    subjectId = subject;
    topicId = topic;
    progress = TopicProgress(subjectId: subjectId, topicId: topicId);
    _loadQuestion();
    notifyListeners();
  }

  void _loadQuestion() {
    final qs = curriculum.questionsFor(
      subjectId,
      topicId,
      progress.difficulty,
    );
    currentQuestion = qs.isNotEmpty ? qs.first : null;
  }

  Future<void> answer(int selectedIndex) async {
    if (currentQuestion == null) return;
    final isCorrect = selectedIndex == currentQuestion!.correctIndex;

    var updated = progress.copyWith(
      totalAnswered: progress.totalAnswered + 1,
      totalCorrect: progress.totalCorrect + (isCorrect ? 1 : 0),
      correctStreak: isCorrect ? progress.correctStreak + 1 : 0,
      wrongStreak: isCorrect ? 0 : progress.wrongStreak + 1,
    );

    // adaptive rules
    if (updated.correctStreak >= 3 && updated.difficulty < 2) {
      updated = updated.copyWith(correctStreak: 0, wrongStreak: 0, difficulty: updated.difficulty + 1);
    } else if (updated.wrongStreak >= 2 && updated.difficulty > 0) {
      updated = updated.copyWith(correctStreak: 0, wrongStreak: 0, difficulty: updated.difficulty - 1);
    }

    updated = updated.copyWith(mastery: TopicProgress.calculateMastery(updated));

    progress = updated;
    _loadQuestion();
    notifyListeners();
  }
}




import 'package:flutter/foundation.dart';

@immutable
class Question {
  final String id;
  final String subjectId;
  final String topicId;
  final int difficulty; // 0 easy, 1 medium, 2 hard
  final String prompt;
  final List<String> options;
  final int correctIndex;

  const Question({
    required this.id,
    required this.subjectId,
    required this.topicId,
    required this.difficulty,
    required this.prompt,
    required this.options,
    required this.correctIndex,
  });
}

class CurriculumService {
  // tiny in-memory “UK” curriculum
  final Map<String, String> subjects = {
    'maths': 'Mathematics',
    'eng': 'English',
    'sci': 'Science',
  };

  final Map<String, List<String>> topicsBySubject = {
    'maths': ['fractions', 'algebra'],
    'eng': ['reading'],
    'sci': ['cells'],
  };

  final Map<String, String> topicNames = {
    'fractions': 'Fractions',
    'algebra': 'Algebra basics',
    'reading': 'Reading comprehension',
    'cells': 'Cells & organelles',
  };

  final List<Question> _questions = [
    Question(
      id: 'q1',
      subjectId: 'maths',
      topicId: 'fractions',
      difficulty: 0,
      prompt: 'What is 1/2 + 1/2?',
      options: ['1', '2', '1/4', '3/4'],
      correctIndex: 0,
    ),
    Question(
      id: 'q2',
      subjectId: 'maths',
      topicId: 'fractions',
      difficulty: 1,
      prompt: 'Simplify 6/8',
      options: ['3/4', '6/4', '2/3', '1/2'],
      correctIndex: 0,
    ),
    Question(
      id: 'q3',
      subjectId: 'maths',
      topicId: 'algebra',
      difficulty: 0,
      prompt: 'Solve: x + 3 = 5',
      options: ['1', '2', '3', '5'],
      correctIndex: 1,
    ),
  ];

  List<Question> questionsFor(String subjectId, String topicId, int difficulty) {
    return _questions
        .where((q) =>
            q.subjectId == subjectId &&
            q.topicId == topicId &&
            q.difficulty == difficulty)
        .toList();
  }
}
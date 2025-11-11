// lib/services/auth_service.dart
import 'package:flutter/foundation.dart';

enum UserRole { student, teacher, parent }

class AuthService extends ChangeNotifier {
  final Map<String, Map<String, dynamic>> _users = {
    'alice_student': {
      'password': 'pass123',
      'role': UserRole.student,
      'studentId': '1',
    },
    'mr_jones': {
      'password': 'teach123',
      'role': UserRole.teacher,
    },
    'alice_mum': {
      'password': 'parent123',
      'role': UserRole.parent,
      'studentId': '1',
    },
  };

  UserRole? _currentRole;
  String? _currentStudentId;
  String? _currentUsername;

  UserRole? get currentRole => _currentRole;
  String? get currentStudentId => _currentStudentId;
  String? get currentUsername => _currentUsername;

  bool login(String username, String password) {
    final user = _users[username];
    if (user == null) return false;
    if (user['password'] != password) return false;

    _currentRole = user['role'] as UserRole;
    _currentStudentId = user['studentId'] as String?;
    _currentUsername = username;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentRole = null;
    _currentStudentId = null;
    _currentUsername = null;
    notifyListeners();
  }
}
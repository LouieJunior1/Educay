import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final String role; // 'student' | 'teacher' | 'parent'
  const LoginScreen({super.key, required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.role} login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _userCtrl,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final ok = context
                    .read<AuthService>()
                    .login(_userCtrl.text.trim(), _passCtrl.text.trim());
                if (!ok) {
                  setState(() => _error = 'Invalid username or password');
                  return;
                }
                final role = context.read<AuthService>().currentRole;
                if (role == UserRole.teacher) {
                  Navigator.pushReplacementNamed(context, '/teacher');
                } else if (role == UserRole.student) {
                  Navigator.pushReplacementNamed(context, '/student-home');
                } else {
                  Navigator.pushReplacementNamed(context, '/parent-home');
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
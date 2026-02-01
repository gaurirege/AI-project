import 'dart:ui';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'disclaimer_screen.dart';
import '../api_service.dart';
import '../components/ui_components.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // 1. Check if fields are empty
    if (username.isEmpty || password.isEmpty) {
      UIComponents.showAlert(context, "Please fill in all fields");
      return;
    }

    // 2. Check password length
    if (password.length < 6) {
      UIComponents.showAlert(context, "Password must be at least 6 characters");
      return;
    }

    setState(() => _isLoading = true);
    final result = await ApiService.login(username, password);
    setState(() => _isLoading = false);

    if (result["success"]) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DisclaimerScreen()),
      );
    } else {
      UIComponents.showAlert(context, result["message"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF008080), Color(0xFFE0F7FA)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock_person_rounded, size: 64, color: Color(0xFF004D40)),
                      const SizedBox(height: 16),
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF004D40),
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "Username",
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "Password",
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 32),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _handleLogin,
                              child: const Text("LOGIN", style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.bold)),
                            ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignupScreen()),
                          );
                        },
                        child: const Text(
                          "New User? Don’t have an account? Signup",
                          style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cipherx/screens/auth-screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AuthScreen()));
        },
        child: const Icon(Icons.arrow_forward_ios_outlined),
      ),
      backgroundColor: Colors.purple,
    );
  }
}

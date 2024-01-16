import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cipherx/screens/home.dart';
import 'package:cipherx/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashS extends StatelessWidget {
  const SplashS({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        color: Colors.deepPurple,
      ), // Replace with your splash image
      nextScreen: FirebaseAuth.instance.currentUser != null
          ? Home()
          : const WelcomeScreen(),
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
    );
  }
}

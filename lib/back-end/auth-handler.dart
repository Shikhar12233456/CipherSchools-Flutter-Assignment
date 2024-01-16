import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHandler {
  final auth = FirebaseAuth.instance;
  Future<void> signUpWithEmailPassword(
      String name, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signUpwithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      await auth.signInWithCredential(authCredential);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}

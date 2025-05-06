import 'package:application_project/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userPhoneKey = 'user_phone';

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get stored phone number
  static Future<String?> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userPhoneKey);
  }

  // Store login information
  static Future<void> saveLoginInfo(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userPhoneKey, phone);
  }

  // Clear login information
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.remove(_userPhoneKey);
  }
  // Add this inside the AuthService class

  Future<UserCredential?> registerWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Email Registration Error: $e");
      return null;
    }
  }

  Future<UserCredential?> loginWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Email/Password Login Error: $e");
      return null;
    }
  }

  Future<UserCredential?> loginWithGoogle(context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      if (_auth.currentUser != null) {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
      }

      return await _auth.signInWithCredential(cred);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> logOut(context) async {
    if (_auth.currentUser != null) {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Navigator.of(context).pop();
    }
  }
}

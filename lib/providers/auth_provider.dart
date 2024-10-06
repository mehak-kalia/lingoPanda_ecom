// providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isAuthenticated = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool get isAuthenticated => _isAuthenticated;

  User? get user => _user; // Add a getter for the user

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      _isAuthenticated = false;
      notifyListeners(); // Notify listeners in case of error
      throw Exception('Login failed: $e'); // Throw exception for UI handling
    }
  }

  Future<void> register({required String email, required String password, String name = ""}) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store user data in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': email,
        'name': name, // Store additional user information only
      });

      // Registration successful
      _user = userCredential.user; // Set the user
      _isAuthenticated = true; // Update authentication status
      notifyListeners(); // Notify listeners about state change
    } catch (e) {
      // Handle error (e.g., show an error message)
      print('Registration error: $e');
      throw Exception('Registration failed: $e'); // Throw exception for UI handling
    }
  }

  // Optional: Add a sign-out method
  Future<void> signOut() async {
    await _auth.signOut();
    _isAuthenticated = false;
    _user = null; // Clear user data on sign out
    notifyListeners(); // Notify listeners about state change
  }
}

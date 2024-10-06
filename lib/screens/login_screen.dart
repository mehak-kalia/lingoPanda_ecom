import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart'; // Import your HomeScreen
import 'register_screen.dart'; // Import your RegisterScreen

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController(); // Controller for email input
  final _passwordController = TextEditingController(); // Controller for password input
  final _formKey = GlobalKey<FormState>(); // Key for the Form

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context); // Accessing AuthProvider

    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 250, 1.0), // Background color of the login screen
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 75, // Height of the AppBar
        title: Text(
          "e-Shop", // Title of the AppBar
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color.fromRGBO(10, 80, 190, 1.0), // Color of the title
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding for the form
        child: Form( // Form widget for input validation
          key: _formKey, // Assign the key to the Form
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 7, top: MediaQuery.of(context).size.height / 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Name field
                      TextField(
                        decoration: InputDecoration(
                          labelText: '',
                          hintText: 'Enter your name', // Placeholder for the input
                          hintStyle: GoogleFonts.poppins(color: Colors.grey), // Style for hint text
                          filled: true,
                          fillColor: Colors.transparent, // Background color for input
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none, // No border
                          ),
                        ),
                      ),

                      // Email field with validation
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          hintStyle: GoogleFonts.poppins(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) { // Validation for email
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email'; // Error message if empty
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email'; // Error message if invalid format
                          }
                          return null; // If validation passes
                        },
                      ),
                      SizedBox(height: 10), // Spacing between fields

                      // Password field with validation
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          hintStyle: GoogleFonts.poppins(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        obscureText: true, // Hides password input
                        validator: (value) { // Validation for password
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password'; // Error message if empty
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters'; // Error message for short password
                          }
                          return null; // If validation passes
                        },
                      ),
                      Spacer(),

                      // Login button
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(10, 80, 190, 1.0), // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) { // Validate the form
                              // Proceed with login
                              authProvider.login(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            }
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      // "New here? SignUp" text with navigation
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Navigate to the register screen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'New here? ',
                                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: 'SignUp',
                                  style: GoogleFonts.poppins(color: Color.fromRGBO(10, 80, 190, 1.0), fontWeight: FontWeight.w700), // SignUp color
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

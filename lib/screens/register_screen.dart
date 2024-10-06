import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingo_panda_ecom/screens/login_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController(); // Controller for name input
  final TextEditingController emailController = TextEditingController(); // Controller for email input
  final TextEditingController passwordController = TextEditingController(); // Controller for password input
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Key for the Form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 250, 1.0), // Background color of the register screen
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
                  padding: EdgeInsets.only(left: 7, top: MediaQuery.of(context).size.height / 6), // Top padding for alignment
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Name field
                      TextFormField(
                        controller: nameController, // Controller for the name input
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your name', // Placeholder for the input
                          hintStyle: GoogleFonts.poppins(color: Colors.grey), // Style for hint text
                          filled: true,
                          fillColor: Colors.white, // Background color for input
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none, // No border
                          ),
                        ),
                        validator: (value) { // Validation for name input
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name'; // Error message if empty
                          }
                          return null; // If validation passes
                        },
                      ),
                      SizedBox(height: 10), // Spacing between fields
                      // Email field with validation
                      TextFormField(
                        controller: emailController, // Controller for the email input
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
                        validator: (value) { // Validation for email input
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
                        controller: passwordController, // Controller for the password input
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
                        validator: (value) { // Validation for password input
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password'; // Error message if empty
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters'; // Error message for short password
                          }
                          return null; // If validation passes
                        },
                      ),
                      Spacer(), // Pushes the buttons to the bottom
                      // Sign Up button
                      Container(
                        width: MediaQuery.of(context).size.width / 2, // Button width
                        height: 50, // Button height
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(10, 80, 190, 1.0), // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Rounded corners
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) { // Validate the form
                              // Call the register method from the AuthProvider
                              Provider.of<AuthProvider>(context, listen: false).register(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to HomeScreen after registration
                              );
                            }
                          },
                          child: Text(
                            'SignUp', // Text on the button
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 10), // Spacing between button and text
                      // Navigate to Login screen
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to LoginScreen
                            );
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Already have an account? ', // Text prompting existing users
                                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: 'Login', // "Login" link
                                  style: GoogleFonts.poppins(color: Color.fromRGBO(10, 80, 190, 1.0), fontWeight: FontWeight.w700), // Link color
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

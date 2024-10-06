import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Importing necessary providers and screens
import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

// The main entry point of the application
void main() async {
  // Ensures that widget binding is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Firebase services
  await Firebase.initializeApp();

  // Runs the MyApp widget
  runApp(MyApp());
}

// The root widget of the application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Using MultiProvider to provide multiple providers to the app
      providers: [
        // Providing the AuthProvider for managing authentication state
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Providing the ProductProvider for managing product-related data
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Hides the debug banner
        title: 'E-Commerce App', // Title of the application
        theme: ThemeData(
          primarySwatch: Colors.blue, // Sets the primary color theme for the app
        ),
        home: Consumer<AuthProvider>(
          // Consuming the AuthProvider to determine the initial screen
          builder: (context, authProvider, _) {
            // If the user is authenticated, navigate to the HomeScreen;
            // otherwise, navigate to the LoginScreen
            return authProvider.isAuthenticated ? HomeScreen() : LoginScreen();
          },
        ),
      ),
    );
  }
}

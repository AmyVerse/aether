import 'package:flutter/material.dart';
import 'package:aether/pages/signup.dart'; // Update with the correct path to your SignUpPage file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SignUpPage(), // Set SignUpPage as the home page
    );
  }
}


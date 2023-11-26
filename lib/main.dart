import 'package:flutter/material.dart';
import 'package:mini_challenge_3/screens/home_screen.dart'; // Change to the actual name

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB App',
      theme: ThemeData(
          // Define your app's theme
          ),
      home: HomeScreen(), // Replace with your initial screen
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:provider/provider.dart';
import 'package:mini_challenge_3/widgets/main_screen.dart';

void main() async {
  // Ensure that Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Create an instance of the user profile
  UserProfile userProfile = await UserProfile.getInstance();

  // Run the app with the user profile as a provider
  runApp(
    ChangeNotifierProvider(
      create: (context) => userProfile,
      child: MyApp(userProfile: userProfile),
    ),
  );
}

// The main application widget
class MyApp extends StatelessWidget {
  final UserProfile userProfile;

  // Constructor to receive the user profile
  MyApp({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define the light theme for the app
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue[900],
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      // Define the dark theme for the app
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[900],
        scaffoldBackgroundColor: Colors.blueGrey[900],
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      // Set the theme mode based on the user's preference
      themeMode: userProfile.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      // Set the home screen to the MainScreen widget
      home: MainScreen(userProfile: userProfile),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserProfile userProfile = await UserProfile.getInstance();
  runApp(MyApp(userProfile: userProfile));
}

class MyApp extends StatelessWidget {
  final UserProfile userProfile;

  MyApp({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB App',
      theme: ThemeData(
          // Define the theme for the app
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
          )),
      home: HomeScreen(userProfile: userProfile),
    );
  }
}

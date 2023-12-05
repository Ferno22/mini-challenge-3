import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'popular_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserProfile userProfile;

  HomeScreen({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB App'),
        titleSpacing: 20.0,
        toolbarHeight: 80.0,
        backgroundColor: Colors.blueGrey[900]?.withOpacity(0.9),
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PopularScreen(userProfile: userProfile)),
                );
              },
              child: Text('Popular Now'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(userProfile: userProfile)),
                );
              },
              child: Text('Search'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(userProfile: userProfile)),
                );
              },
              child: Text('My Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

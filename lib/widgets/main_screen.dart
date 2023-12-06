import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/screens/popular_screen.dart';
import 'package:mini_challenge_3/screens/search_screen.dart';
import 'package:mini_challenge_3/screens/profile_screen.dart';

/// The main screen of the application with a bottom navigation bar.
class MainScreen extends StatefulWidget {
  /// The user profile associated with the current user.
  final UserProfile userProfile;

  /// Constructor that takes the user profile as a parameter.
  MainScreen({required this.userProfile});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// Index of the currently selected tab in the bottom navigation bar.
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // List of widgets corresponding to different screens in the app.
    final List<Widget> _children = [
      PopularScreen(userProfile: widget.userProfile),
      SearchScreen(userProfile: widget.userProfile),
      ProfileScreen(userProfile: widget.userProfile),
    ];

    return Scaffold(
      body: _children[_currentIndex], // Display the selected screen.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected tab index.
          });
        },
      ),
    );
  }
}

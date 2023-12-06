import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/screens/popular_screen.dart';
import 'package:mini_challenge_3/screens/search_screen.dart';
import 'package:mini_challenge_3/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final UserProfile userProfile;

  MainScreen({required this.userProfile});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      PopularScreen(userProfile: widget.userProfile),
      SearchScreen(userProfile: widget.userProfile),
      ProfileScreen(userProfile: widget.userProfile),
    ];

    return Scaffold(
      body: _children[_currentIndex],
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
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

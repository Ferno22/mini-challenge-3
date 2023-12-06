import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/screens/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  final UserProfile userProfile;

  ProfileScreen({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: <Widget>[
          // Add actions list to AppBar
          IconButton(
            icon: Icon(Icons.settings), // Add settings icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                      userProfile: userProfile), // Navigate to SettingsScreen
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const ListTile(
            title: Text('My Watchlist',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userProfile.watchlist.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> movie = userProfile.watchlist[index];
                return ListTile(
                  leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['posterPath']}'),
                  title: Text(movie['title'] ?? 'Unknown Title'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      userProfile.watchlist.removeAt(index);
                      userProfile.saveProfile();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(userProfile: userProfile)),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const ListTile(
            title: Text('My Rated List',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userProfile.ratedList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> ratedItem = userProfile.ratedList[index];
                return ListTile(
                  leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${ratedItem['posterPath']}'),
                  title: Text(ratedItem['title'] ?? 'Unknown Title'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          userProfile.ratedList.removeAt(index);
                          userProfile.saveProfile();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(userProfile: userProfile)),
                          );
                        },
                      ),
                    ],
                  ),
                  subtitle: Text('Rating: ${ratedItem['rating']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

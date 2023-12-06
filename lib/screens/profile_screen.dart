import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/screens/settings_screen.dart';

/// Widget for displaying user profile information, including watchlist and rated list.
class ProfileScreen extends StatelessWidget {
  /// The user profile associated with the current user.
  final UserProfile userProfile;

  /// Constructor that takes the user profile as a parameter.
  ProfileScreen({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: <Widget>[
          // Add settings icon to AppBar for navigating to SettingsScreen
          IconButton(
            icon: Icon(Icons.settings),
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
          // Watchlist section
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
                  // Display movie poster
                  leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie['posterPath']}'),
                  // Display movie title
                  title: Text(movie['title'] ?? 'Unknown Title'),
                  // Add remove button to remove movie from watchlist
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      userProfile.watchlist.removeAt(index);
                      userProfile.saveProfile();
                      // Refresh the profile screen after removing an item
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
          // Rated List section
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
                  // Display rated item poster
                  leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${ratedItem['posterPath']}'),
                  // Display rated item title
                  title: Text(ratedItem['title'] ?? 'Unknown Title'),
                  // Add remove button to remove rated item from the list
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          userProfile.ratedList.removeAt(index);
                          userProfile.saveProfile();
                          // Refresh the profile screen after removing an item
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
                  // Display rated item rating as a subtitle
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

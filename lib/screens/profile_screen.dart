import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/screens/movie_details_screen.dart';

class ProfileScreen extends StatelessWidget {
  final UserProfile userProfile;

  ProfileScreen({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Watchlist',
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
        ],
      ),
    );
  }
}

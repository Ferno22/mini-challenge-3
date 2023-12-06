import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/movie.dart';
import 'package:mini_challenge_3/models/user_profile.dart';

/// A button for marking a movie as a favorite.
class FavoriteButtonMovie extends StatefulWidget {
  /// The user profile associated with the current user.
  final UserProfile userProfile;

  /// The movie for which the favorite button is displayed.
  final Movie movie;

  /// Constructor that takes the user profile and movie as parameters.
  FavoriteButtonMovie({required this.userProfile, required this.movie});

  @override
  _FavoriteButtonStateMovie createState() => _FavoriteButtonStateMovie();
}

class _FavoriteButtonStateMovie extends State<FavoriteButtonMovie> {
  /// Checks if the movie is already in the user's watchlist.
  bool isFavoriteMovie() {
    return widget.userProfile.watchlist
        .any((movie) => movie['id'] == widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isFavoriteMovie()
          ? Icon(Icons.favorite)
          : Icon(Icons.favorite_border),
      onPressed: () {
        setState(() {
          if (!isFavoriteMovie()) {
            widget.userProfile.watchlist.add(widget.movie.toJson());
          } else {
            widget.userProfile.watchlist
                .removeWhere((movie) => movie['id'] == widget.movie.id);
          }
          widget.userProfile.saveProfile();
        });
      },
    );
  }
}

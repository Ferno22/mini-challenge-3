import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/movie.dart';
import 'package:mini_challenge_3/models/user_profile.dart';

class FavoriteButtonMovie extends StatefulWidget {
  final UserProfile userProfile;
  final Movie movie;

  FavoriteButtonMovie({required this.userProfile, required this.movie});

  @override
  _FavoriteButtonStateMovie createState() => _FavoriteButtonStateMovie();
}

class _FavoriteButtonStateMovie extends State<FavoriteButtonMovie> {
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

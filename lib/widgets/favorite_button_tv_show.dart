import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/tv_show.dart';
import 'package:mini_challenge_3/models/user_profile.dart';

/// A button for marking a TV show as a favorite.
class FavoriteButtonTVShow extends StatefulWidget {
  /// The user profile associated with the current user.
  final UserProfile userProfile;

  /// The TV show for which the favorite button is displayed.
  final TVShow tvShow;

  /// Constructor that takes the user profile and TV show as parameters.
  FavoriteButtonTVShow({required this.userProfile, required this.tvShow});

  @override
  _FavoriteButtonStateTVShow createState() => _FavoriteButtonStateTVShow();
}

class _FavoriteButtonStateTVShow extends State<FavoriteButtonTVShow> {
  /// Checks if the TV show is already in the user's watchlist.
  bool isFavoriteTVShow() {
    return widget.userProfile.watchlist
        .any((tvShow) => tvShow['id'] == widget.tvShow.id);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isFavoriteTVShow()
          ? Icon(Icons.favorite)
          : Icon(Icons.favorite_border),
      onPressed: () {
        setState(() {
          if (!isFavoriteTVShow()) {
            widget.userProfile.watchlist.add(widget.tvShow.toJson());
          } else {
            widget.userProfile.watchlist
                .removeWhere((tvShow) => tvShow['id'] == widget.tvShow.id);
          }
          widget.userProfile.saveProfile();
        });
      },
    );
  }
}

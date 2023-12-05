import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/tv_show.dart';
import 'package:mini_challenge_3/models/user_profile.dart';

class FavoriteButtonTVShow extends StatefulWidget {
  final UserProfile userProfile;
  final TVShow tvShow;

  FavoriteButtonTVShow({required this.userProfile, required this.tvShow});

  @override
  _FavoriteButtonStateTVShow createState() => _FavoriteButtonStateTVShow();
}

class _FavoriteButtonStateTVShow extends State<FavoriteButtonTVShow> {
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

import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/tv_show.dart';
import 'package:mini_challenge_3/models/user_profile.dart';

/// Widget for rating TV shows.
class RatingButtonTVShow extends StatefulWidget {
  /// The user profile associated with the current user.
  final UserProfile userProfile;

  /// The TV show to be rated.
  final TVShow tvShow;

  /// Constructor that takes the user profile and the TV show as parameters.
  RatingButtonTVShow({required this.userProfile, required this.tvShow});

  @override
  _RatingButtonStateTVShow createState() => _RatingButtonStateTVShow();
}

class _RatingButtonStateTVShow extends State<RatingButtonTVShow> {
  /// The initial rating, retrieved from the user's rated list.
  int rating = 0;

  @override
  void initState() {
    super.initState();
    // Get the initial rating from the user's rated list.
    rating = widget.userProfile.ratedList.firstWhere(
          (element) => element['id'] == widget.tvShow.id,
          orElse: () => {'rating': 0},
        )['rating'] ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Dropdown button for selecting the rating.
        DropdownButton<int>(
          value: rating,
          items: List.generate(
            11,
            (index) => DropdownMenuItem(value: index, child: Text("$index")),
          ),
          onChanged: (newRating) {
            setState(() {
              // Update the rating and save it to the user's profile.
              rating = newRating!;
              widget.userProfile.ratedList.add({
                'id': widget.tvShow.id,
                'rating': rating,
                'posterPath': widget.tvShow.posterPath,
                'title': widget.tvShow.title,
              });
              widget.userProfile.saveProfile();
            });
          },
        ),
        Text('Rate this TV show'),
      ],
    );
  }
}

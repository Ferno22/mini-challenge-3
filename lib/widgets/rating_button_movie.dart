import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/movie.dart';
import 'package:mini_challenge_3/models/user_profile.dart';

/// Widget for rating movies.
class RatingButtonMovie extends StatefulWidget {
  /// The user profile associated with the current user.
  final UserProfile userProfile;

  /// The movie to be rated.
  final Movie movie;

  /// Constructor that takes the user profile and the movie as parameters.
  RatingButtonMovie({required this.userProfile, required this.movie});

  @override
  _RatingButtonStateMovie createState() => _RatingButtonStateMovie();
}

class _RatingButtonStateMovie extends State<RatingButtonMovie> {
  /// The initial rating, retrieved from the user's rated list.
  int rating = 0;

  @override
  void initState() {
    super.initState();
    // Get the initial rating from the user's rated list.
    rating = widget.userProfile.ratedList.firstWhere(
          (element) => element['id'] == widget.movie.id,
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
                'id': widget.movie.id,
                'rating': rating,
                'posterPath': widget.movie.posterPath,
                'title': widget.movie.title,
              });
              widget.userProfile.saveProfile();
            });
          },
        ),
        Text('Rate this movie'),
      ],
    );
  }
}

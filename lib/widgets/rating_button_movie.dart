import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/movie.dart';
import 'package:mini_challenge_3/models/user_profile.dart';

class RatingButtonMovie extends StatefulWidget {
  final UserProfile userProfile;
  final Movie movie;
  RatingButtonMovie({required this.userProfile, required this.movie});
  @override
  _RatingButtonStateMovie createState() => _RatingButtonStateMovie();
}

class _RatingButtonStateMovie extends State<RatingButtonMovie> {
  int rating = 0;

  @override
  void initState() {
    super.initState();
    rating = widget.userProfile.ratedList.firstWhere(
            (element) => element['id'] == widget.movie.id,
            orElse: () => {'rating': 0})['rating'] ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<int>(
          value: rating,
          items: List.generate(11,
              (index) => DropdownMenuItem(value: index, child: Text("$index"))),
          onChanged: (newRating) {
            setState(() {
              rating = newRating!;
              widget.userProfile.ratedList.add({
                'id': widget.movie.id,
                'rating': rating,
                'posterPath': widget.movie.posterPath,
                'title': widget.movie.title
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

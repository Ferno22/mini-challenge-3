import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/tv_show.dart';
import 'package:mini_challenge_3/models/user_profile.dart';

class RatingButtonTVShow extends StatefulWidget {
  final UserProfile userProfile;
  final TVShow tvShow;

  RatingButtonTVShow({required this.userProfile, required this.tvShow});

  @override
  _RatingButtonStateTVShow createState() => _RatingButtonStateTVShow();
}

class _RatingButtonStateTVShow extends State<RatingButtonTVShow> {
  int rating = 0;

  @override
  void initState() {
    super.initState();
    rating = widget.userProfile.ratedList.firstWhere(
            (element) => element['id'] == widget.tvShow.id,
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
                'id': widget.tvShow.id,
                'rating': rating,
                'posterPath': widget.tvShow.posterPath,
                'title': widget.tvShow.title
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

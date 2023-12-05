import 'package:flutter/material.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';
import 'package:mini_challenge_3/models/movie.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/widgets/favorite_button_movie.dart';
import 'package:mini_challenge_3/widgets/rating_button_movie.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int id;
  final UserProfile userProfile;
  MovieDetailsScreen({required this.id, required this.userProfile});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: FutureBuilder(
        future: Future.wait([
          TmdbApi().getMovieDetails(widget.id),
          TmdbApi().getMovieCredits(widget.id),
          TmdbApi().getMovieProviders(widget.id),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('An error occurred'));
          } else {
            if (snapshot.data != null) {
              List<dynamic> responses = snapshot.data as List<dynamic>;
              Map<String, dynamic> movieDetails = responses[0];
              Map<String, dynamic> movieCredits = responses[1];
              Map<String, dynamic> movieProviders = responses[2];

              Movie movie =
                  Movie.fromJson(movieDetails, movieCredits, movieProviders);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                      Text('Cast: ${movie.castMembers.join(', ')}'),
                      Text('Director: ${movie.director}'),
                      Text('Release Date: ${movie.releaseDate}'),
                      Text('PEGI Info: ${movie.pegiInfo}'),
                      Text('Genre: ${movie.genre}'),
                      Text('Summary: ${movie.summary}'),
                      Text('Duration: ${movie.duration}'),
                      Text('Rating: ${movie.rating.toString()}'),
                      Text('Services: ${movie.services?.join(', ')}'),
                      FavoriteButtonMovie(
                          userProfile: widget.userProfile, movie: movie),
                      RatingButtonMovie(
                          userProfile: widget.userProfile, movie: movie),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text('No data available'));
            }
          }
        },
      ),
    );
  }
}

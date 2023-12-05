import 'package:flutter/material.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';
import 'package:mini_challenge_3/models/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;

  MovieDetailsScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: FutureBuilder(
        future: Future.wait([
          TmdbApi().getMovieDetails(id),
          TmdbApi().getMovieCredits(id),
          TmdbApi().getMovieProviders(id),
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

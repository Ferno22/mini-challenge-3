import 'package:flutter/material.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';

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
        future: TmdbApi().getMovieDetails(id),
        builder: (context, snapshot) {
          // Implement UI to display movie details using the snapshot data
          return Center(
            child: Text('Movie Details Screen'),
          );
        },
      ),
    );
  }
}

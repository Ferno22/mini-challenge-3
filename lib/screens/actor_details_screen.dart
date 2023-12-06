import 'package:flutter/material.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';
import 'package:mini_challenge_3/models/actor.dart'; // Import the Actor model

/// Widget for displaying details of a specific actor, including their movies and TV shows.
class ActorDetailsScreen extends StatelessWidget {
  /// The unique identifier of the actor.
  final int id;

  /// Constructor that takes the actor's ID as a parameter.
  ActorDetailsScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actor Details'),
      ),
      body: FutureBuilder(
        // Fetch actor details, movies, and TV shows asynchronously
        future: Future.wait([
          TmdbApi().getActorDetails(id),
          TmdbApi().getActorMovies(id),
          TmdbApi().getActorTvShows(id),
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
              Map<String, dynamic> actorDetails = responses[0];
              Map<String, dynamic> actorMovies = responses[1];
              Map<String, dynamic> actorTvShows = responses[2];

              // Create an Actor object from the JSON data
              Actor actor =
                  Actor.fromJson(actorDetails, actorMovies, actorTvShows);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(actor.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('Age: ${actor.age}'),
                      Image.network(
                          'https://image.tmdb.org/t/p/w500${actor.profilePath}'),
                      Text('Movies:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      for (var movie in actor.movies) Text(movie),
                      Text('TV Shows:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      for (var tvShow in actor.tvShows) Text(tvShow),
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

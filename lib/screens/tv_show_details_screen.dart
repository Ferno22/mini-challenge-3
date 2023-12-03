import 'package:flutter/material.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';
import 'package:mini_challenge_3/models/tv_show.dart';

class TVShowDetailsScreen extends StatelessWidget {
  final int id;

  TVShowDetailsScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Show Details'),
      ),
      body: FutureBuilder<TVShow>(
        future: TmdbApi().getTvShowDetails(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            TVShow tvShow = snapshot.data!;
            return ListView(
              children: <Widget>[
                Text('Title: ${tvShow.title}'),
                Text('Cast: ${tvShow.castMembers.join(', ')}'),
                Text('Director: ${tvShow.director}'),
                Text('Release Date: ${tvShow.releaseDate}'),
                Text('PEGI Info: ${tvShow.pegiInfo}'),
                Text('Genre: ${tvShow.genre}'),
                Text('Summary: ${tvShow.summary}'),
                Text('Duration: ${tvShow.duration}'),
                Text('Rating: ${tvShow.rating.toString()}'),
                Text('Number of Seasons: ${tvShow.numberOfSeasons}'),
                Text('Number of Episodes: ${tvShow.numberOfEpisodes}'),
              ],
            );
          }
        },
      ),
    );
  }
}

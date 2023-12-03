// When clicking into a film, the user should navigate to this screen
// This screen should display the following information:
// Y At least 3 cast members
// Y The year of release
// Y The director
// Y The release date
// Y PEGI info
// Y The genre
// Y A summary
// Y The length (duration)
// Y The rating
// In case of a TV series, the screen should also display:
// Y The number of seasons
// Y The number of episodes
// Optionally, the screen could allow the user to:
// - Navigate across seasons
// - Navigate across episodes
// If the item (movie or TV show) is available on the user's selected services, an icon of these services should appear.

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
      body: FutureBuilder(
        future: Future.wait([
          TmdbApi().getTvShowDetails(id),
          TmdbApi().getTvShowCredits(id),
          TmdbApi().getTvShowProviders(id),
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
              Map<String, dynamic> tvShowDetails = responses[0];
              Map<String, dynamic> tvShowCredits = responses[1];
              Map<String, dynamic> tvShowProviders = responses[2];

              TVShow tvShow = TVShow.fromJson(
                  tvShowDetails, tvShowCredits, tvShowProviders);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tvShow.title,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Image.network(
                          'https://image.tmdb.org/t/p/w500${tvShow.posterPath}'),
                      Text('Created By: ${tvShow.creatorNames.join(', ')}'),
                      Text('First Air Date: ${tvShow.firstAirDate}'),
                      Text('Last Air Date: ${tvShow.lastAirDate}'),
                      Text('Number of Seasons: ${tvShow.numberOfSeasons}'),
                      Text('Number of Episodes: ${tvShow.numberOfEpisodes}'),
                      Text(
                          'Average Episode Run Time: ${tvShow.averageEpisodeRunTime[0]}'), // Display the average runtime
                      Text('Summary: ${tvShow.overview}'),
                      Text('Genres: ${tvShow.genres.join(', ')}'),
                      Text('Cast Members: ${tvShow.castMembers.join(', ')}'),
                      Text('PEGI: ${tvShow.adult ? 'R' : 'PG'}'),
                      Text(
                          'In Production: ${tvShow.inProduction ? 'Yes' : 'No'}'),
                      Text('Rating: ${tvShow.rating.toString()}'),
                      Text('Services: ${tvShow.providers.join(', ')}'),
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

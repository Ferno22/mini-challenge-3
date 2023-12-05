import 'package:flutter/material.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';
import 'package:mini_challenge_3/models/tv_show.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/widgets/favorite_button_tv_show.dart';

class TVShowDetailsScreen extends StatefulWidget {
  final int id;
  final UserProfile userProfile;

  TVShowDetailsScreen({required this.id, required this.userProfile});

  @override
  _TVShowDetailsScreenState createState() => _TVShowDetailsScreenState();
}

class _TVShowDetailsScreenState extends State<TVShowDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Show Details'),
      ),
      body: FutureBuilder(
        future: Future.wait([
          TmdbApi().getTvShowDetails(widget.id),
          TmdbApi().getTvShowCredits(widget.id),
          TmdbApi().getTvShowProviders(widget.id),
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
                      FavoriteButtonTVShow(
                          userProfile: widget.userProfile, tvShow: tvShow),
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

import 'package:flutter/material.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';

class ActorDetailsScreen extends StatelessWidget {
  final int id;

  ActorDetailsScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actor Details'),
      ),
      body: FutureBuilder(
        future: TmdbApi().getActorDetails(id),
        builder: (context, snapshot) {
          // Implement UI to display actor details using the snapshot data
          return Center(
            child: Text('Actor Details Screen'),
          );
        },
      ),
    );
  }
}

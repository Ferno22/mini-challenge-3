import 'package:flutter/material.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TmdbApi _api = TmdbApi();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Now'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Movies'),
            Tab(text: 'Series'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FutureBuilder(
            future: _api.getPopularMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                var movies = snapshot.data?['results'];
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10, // Add horizontal spacing
                    mainAxisSpacing: 10, // Add vertical spacing
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    var movie = movies[index];
                    return Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie['poster_path'] ?? ''}',
                            width: double.infinity,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.black54,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(movie['title'] ?? '',
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
          FutureBuilder(
            future: _api.getPopularSeries(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                var series = snapshot.data?['results'];
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10, // Add horizontal spacing
                    mainAxisSpacing: 10, // Add vertical spacing
                  ),
                  itemCount: series.length,
                  itemBuilder: (context, index) {
                    var serie = series[index];
                    return Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${serie['poster_path'] ?? ''}',
                            width: double.infinity,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.black54,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(serie['name'] ?? '',
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}

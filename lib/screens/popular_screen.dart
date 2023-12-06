import 'package:flutter/material.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/screens/movie_details_screen.dart';
import 'package:mini_challenge_3/screens/tv_show_details_screen.dart';

/// Widget for displaying popular movies and TV shows with the option to switch
/// between movies and TV series using a TabBar.
class PopularScreen extends StatefulWidget {
  /// The user profile associated with the current user.
  final UserProfile userProfile;

  /// Constructor that takes the user profile as a parameter.
  PopularScreen({required this.userProfile});

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
    // Determine if we are in dark mode or light mode
    var brightness = Theme.of(context).brightness;
    var isDarkMode = brightness == Brightness.dark;

    // Choose colors based on the theme
    var backgroundColor = isDarkMode ? Colors.blueGrey[900] : Colors.white;
    var textColor = isDarkMode ? Colors.white : Colors.black;
    var accentColor = isDarkMode ? Colors.cyanAccent : Colors.blue;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0, // Remove the shadow
        title: Text(
          'Popular Now',
          style: TextStyle(color: textColor), // Customize title color
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: accentColor, width: 1),
              ),
              labelColor: accentColor, // Customize text color for selected tab
              unselectedLabelColor:
                  textColor, // Customize text color for unselected tab
              tabs: const [
                Tab(
                  text: 'Movies',
                ),
                Tab(
                  text: 'Series',
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _buildMediaGrid(_api.getPopularMovies()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: _buildMediaGrid(_api.getPopularTvShows()),
          ),
        ],
      ),
    );
  }

  /// Build a GridView of popular movies or TV shows based on the provided future.
  Widget _buildMediaGrid(Future<Map<String, dynamic>> future) {
    // Determine if we are in dark mode or light mode
    var brightness = Theme.of(context).brightness;
    var isDarkMode = brightness == Brightness.dark;

    // Choose colors based on the theme
    var textColor = isDarkMode ? Colors.white : Colors.black;

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          var mediaList = snapshot.data?['results'];
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: mediaList.length,
            itemBuilder: (context, index) {
              var media = mediaList[index];
              return GestureDetector(
                onTap: () {
                  if (_tabController.index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(
                            id: media['id'], userProfile: widget.userProfile),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TVShowDetailsScreen(
                            id: media['id'], userProfile: widget.userProfile),
                      ),
                    );
                  }
                },
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${media['poster_path'] ?? ''}',
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            media['title'] ?? media['name'] ?? '',
                            style: TextStyle(color: textColor),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

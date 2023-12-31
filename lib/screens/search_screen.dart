import 'package:flutter/material.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/screens/movie_details_screen.dart';
import 'package:mini_challenge_3/screens/tv_show_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'actor_details_screen.dart';

/// Widget for searching movies, TV shows, and actors using the TMDB API.
class SearchScreen extends StatefulWidget {
  /// Identifier for the search screen.
  static const String id = 'search_screen';

  /// The user profile associated with the current user.
  final UserProfile userProfile;

  /// Constructor that takes the user profile as a parameter.
  SearchScreen({required this.userProfile});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<Map<String, dynamic>> _searchResults;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _loadSearchHistory();
    _searchResults = Future.value({});
  }

  void _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _searchHistory = prefs.getStringList('searchHistory') ?? [];
  }

  void _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchHistory', _searchHistory);
  }

  void _search(String query) {
    setState(() {
      _searchResults = TmdbApi().search(query);
      _searchHistory.remove(query); // Remove the query if it already exists
      _searchHistory.insert(0, query); // Add the query to the start of the list
      if (_searchHistory.length > 10) {
        _searchHistory.removeLast(); // Keep the list size to 10
      }
      _saveSearchHistory(); // Save the search history
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchResults = Future.value({});
    });
  }

  void _clearSearchHistory() {
    setState(() {
      _searchHistory.clear();
      _saveSearchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              _search(value);
            } else {
              _clearSearch();
            }
          },
        ),
        actions: [
          // Add button to clear search history
          IconButton(
            onPressed: _clearSearchHistory,
            icon: Icon(Icons.delete),
            tooltip: 'Clear search history',
          ),
          // Add button to clear search text
          IconButton(
            onPressed: () {
              _clearSearch();
              _searchFocusNode.unfocus();
            },
            icon: Icon(Icons.clear),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var results = snapshot.data!['results'];
            if (results != null) {
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  var result = results[index];
                  var title = result['title'] ?? result['name'];
                  var posterPath = result['poster_path'];
                  var id = result['id'];
                  var mediaType = result['media_type'];

                  return ListTile(
                    // Add leading image if there is a poster path
                    leading: posterPath != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w92$posterPath',
                            fit: BoxFit.cover,
                          )
                        : null,
                    // Display title
                    title: Text(title),
                    onTap: () {
                      // Navigate to details screen based on media type
                      if (mediaType == 'movie') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsScreen(
                                id: id, userProfile: widget.userProfile),
                          ),
                        );
                      } else if (mediaType == 'tv') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TVShowDetailsScreen(
                                id: id, userProfile: widget.userProfile),
                          ),
                        );
                      } else if (mediaType == 'person') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActorDetailsScreen(id: id),
                          ),
                        );
                      }
                    },
                  );
                },
              );
            } else {
              // Display search history if no results
              return ListView.builder(
                itemCount: _searchHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_searchHistory[index]),
                    onTap: () {
                      _search(_searchHistory[index]);
                    },
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(
              child: Text('An error occurred'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

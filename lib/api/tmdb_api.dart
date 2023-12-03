import '../models/tv_show.dart';
import '../secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TmdbApi {
  final String? apiKey = Secrets.API_KEY;
  final String baseUrl = 'https://api.themoviedb.org/3';

  // Function to make generic GET requests
  Future<Map<String, dynamic>> _makeGetRequest(String endpoint) async {
    if (apiKey == null) {
      throw Exception('API key is null');
    }

    var response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      var body = response.body;
      if (body != null) {
        return jsonDecode(body);
      } else {
        throw Exception('Response body is null');
      }
    } else {
      throw Exception('Failed to load data from TMDB API');
    }
  }

  // Fetch popular movies
  Future<Map<String, dynamic>> getPopularMovies() async {
    return _makeGetRequest('movie/popular?api_key=$apiKey');
  }

  // Fetch popular TV series
  Future<Map<String, dynamic>> getPopularSeries() async {
    return _makeGetRequest('tv/popular?api_key=$apiKey');
  }

  // Search for movies, TV shows, or actors
  Future<Map<String, dynamic>> search(String query) async {
    return _makeGetRequest('search/multi?api_key=$apiKey&query=$query');
  }

  // Fetch details for a specific movie or TV show
  Future<Map<String, dynamic>> getMovieDetails(int id) async {
    return _makeGetRequest('movie/$id');
  }

  Future<TVShow> getTvShowDetails(int id) async {
    Map<String, dynamic> response = await _makeGetRequest('tv/$id');

    return TVShow(
      id: response['id'],
      title: response['name'],
      posterPath: response['poster_path'],
      castMembers:
          List<String>.from(response['cast'].map((item) => item['name'])),
      director: response['created_by'][0]['name'],
      releaseDate: response['first_air_date'],
      pegiInfo: response['content_ratings']['results'][0]['rating'],
      genre: response['genres'][0]['name'],
      summary: response['overview'],
      duration: response['episode_run_time'][0].toString(),
      rating: response['vote_average'].toDouble(),
      numberOfSeasons: response['number_of_seasons'],
      numberOfEpisodes: response['number_of_episodes'],
      services:
          List<String>.from(response['networks'].map((item) => item['name'])),
    );
  }

  // Fetch details for a specific actor/actress
  Future<Map<String, dynamic>> getActorDetails(int id) async {
    return _makeGetRequest('person/$id');
  }
}

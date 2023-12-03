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
        print('API Response: $body'); // print the response body
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
  Future<Map<String, dynamic>> getPopularTvShows() async {
    return _makeGetRequest('tv/popular?api_key=$apiKey');
  }

  // Search for movies, TV shows, or actors
  Future<Map<String, dynamic>> search(String query) async {
    return _makeGetRequest('search/multi?api_key=$apiKey&query=$query');
  }

  // Fetch details for a specific movie or TV show
  Future<Map<String, dynamic>> getMovieDetails(int id) async {
    return _makeGetRequest('movie/$id?api_key=$apiKey');
  }

  // Fetch movie credits (cast and director)
  Future<Map<String, dynamic>> getMovieCredits(int id) async {
    return _makeGetRequest('movie/$id/credits?api_key=$apiKey&language=en-US');
  }

  // Fetch movie watch providers
  Future<Map<String, dynamic>> getMovieProviders(int id) async {
    return _makeGetRequest('movie/$id/watch/providers?api_key=$apiKey');
  }

  Future<Map<String, dynamic>> getTvShowDetails(int id) async {
    return _makeGetRequest('tv/$id?api_key=$apiKey');
  }

  Future<Map<String, dynamic>> getTvShowCredits(int id) async {
    return _makeGetRequest('tv/$id/credits?api_key=$apiKey&language=en-US');
  }

  Future<Map<String, dynamic>> getTvShowProviders(int id) async {
    return _makeGetRequest('tv/$id/watch/providers?api_key=$apiKey');
  }

  // Fetch details for a specific actor/actress
  Future<Map<String, dynamic>> getActorDetails(int id) async {
    return _makeGetRequest('person/$id?api_key=$apiKey');
  }

  Future<Map<String, dynamic>> getActorMovies(int id) async {
    return _makeGetRequest('person/$id/movie_credits?api_key=$apiKey');
  }

  Future<Map<String, dynamic>> getActorTvShows(int id) async {
    return _makeGetRequest('person/$id/tv_credits?api_key=$apiKey');
  }
}

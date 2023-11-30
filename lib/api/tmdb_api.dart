import '../secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TmdbApi {
  final String? apiKey = Secrets.API_KEY;
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<Map<String, dynamic>> getPopularMovies() async {
    if (apiKey == null) {
      throw Exception('API key is null');
    }
    var response =
        await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));
    if (response.statusCode == 200) {
      var body = response.body;
      if (body != null) {
        return jsonDecode(body);
      } else {
        throw Exception('Response body is null');
      }
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<Map<String, dynamic>> getPopularSeries() async {
    if (apiKey == null) {
      throw Exception('API key is null');
    }
    var response =
        await http.get(Uri.parse('$baseUrl/tv/popular?api_key=$apiKey'));
    if (response.statusCode == 200) {
      var body = response.body;
      if (body != null) {
        return jsonDecode(body);
      } else {
        throw Exception('Response body is null');
      }
    } else {
      throw Exception('Failed to load popular series');
    }
  }
}

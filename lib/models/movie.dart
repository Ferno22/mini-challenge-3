/// Represents a movie with details such as ID, title, poster path, cast members,
/// director, release date, pegi information, genre, summary, duration, rating, and
/// available streaming services.
class Movie {
  /// Unique identifier for the movie.
  final int id;

  /// The title of the movie.
  final String title;

  /// The path to the movie's poster image.
  final String posterPath;

  /// List of cast members in the movie, limited to the first 3.
  final List<String> castMembers;

  /// The director of the movie.
  final String director;

  /// The release date of the movie.
  final String releaseDate;

  /// The pegi information for the movie, indicating the age suitability.
  final String pegiInfo;

  /// The genre(s) of the movie, represented as a comma-separated string.
  final String genre;

  /// A brief summary or overview of the movie.
  final String summary;

  /// The duration of the movie in minutes.
  final String duration;

  /// The rating of the movie.
  final double rating;

  /// List of streaming services where the movie is available (if applicable).
  final List<String>? services;

  /// Constructor for creating an instance of the [Movie] class.
  ///
  /// All parameters are required except for [services], which is optional.
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.castMembers,
    required this.director,
    required this.releaseDate,
    required this.pegiInfo,
    required this.genre,
    required this.summary,
    required this.duration,
    required this.rating,
    this.services,
  });

  /// Converts the [Movie] object to a JSON format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'castMembers': castMembers,
      'director': director,
      'releaseDate': releaseDate,
      'pegiInfo': pegiInfo,
      'genre': genre,
      'summary': summary,
      'duration': duration,
      'rating': rating,
      'services': services,
    };
  }

  /// Constructor for creating an instance of the [Movie] class from JSON data.
  ///
  /// The [json] parameter contains general movie information, while [creditsJson]
  /// and [providersJson] contain specific data about cast members and streaming
  /// services for the movie, respectively.
  Movie.fromJson(Map<String, dynamic> json, Map<String, dynamic> creditsJson,
      Map<String, dynamic> providersJson)
      : id = json['id'] ?? 0,
        title = json['original_title'] ?? '',
        posterPath = json['poster_path'] ?? '',
        castMembers = (creditsJson['cast'] as List<dynamic>?)
                ?.take(3)
                .map((item) => item['name'] as String)
                .toList() ??
            [],
        director = (creditsJson['crew'] as List<dynamic>?)
                ?.firstWhere((item) => item['job'] == 'Director')['name'] ??
            '',
        releaseDate = json['release_date'] ?? '',
        pegiInfo = json['adult'] ? '18+' : 'PG',
        genre = (json['genres'] as List<dynamic>?)
                ?.map((item) => item['name'] as String)
                .join(', ') ??
            '',
        summary = json['overview'] ?? '',
        duration = '${json['runtime']} min',
        rating = (json['vote_average'] as num?)?.toDouble() ?? 0.0,
        services =
            (providersJson['results']['US']?['flatrate'] as List<dynamic>?)
                    ?.map((item) => item['provider_name'].toString())
                    .toList() ??
                [];
}

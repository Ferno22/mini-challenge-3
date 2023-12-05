class Movie {
  final int id;
  final String title;
  final String posterPath;
  final List<String> castMembers;
  final String director;
  final String releaseDate;
  final String pegiInfo;
  final String genre;
  final String summary;
  final String duration;
  final double rating;
  final List<String>? services;

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
            (providersJson['results']['US']['flatrate'] as List<dynamic>?)
                    ?.map((item) => item['provider_name'].toString())
                    .toList() ??
                [];
}

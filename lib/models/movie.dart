// When clicking into a film, the user should navigate to this screen
// This screen should display the following information:
// - At least 3 cast members
// - The year of release
// - The director
// - The release date
// - PEGI info
// - The genre
// - A summary
// - The length (duration)
// - The rating
// In case of a TV series, the screen should also display:
// - The number of seasons
// - The number of episodes
// Optionally, the screen could allow the user to:
// - Navigate across seasons
// - Navigate across episodes
// If the item (movie or TV show) is available on the user's selected services, an icon of these services should appear.

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

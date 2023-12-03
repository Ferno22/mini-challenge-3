class Actor {
  final int id;
  final String name;
  final String profilePath;
  final int age;
  final List<String> movies;
  final List<String> tvShows;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.age,
    required this.movies,
    required this.tvShows,
  });

  Actor.fromJson(Map<String, dynamic> json, Map<String, dynamic> moviesJson,
      Map<String, dynamic> tvShowsJson)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        profilePath = json['profile_path'] ?? '',
        age = DateTime.now().year - DateTime.parse(json['birthday']).year,
        movies = (moviesJson['cast'] as List<dynamic>?)
                ?.map((item) => item['title'] as String)
                .toList() ??
            [],
        tvShows = (tvShowsJson['cast'] as List<dynamic>?)
                ?.map((item) => item['name'] as String)
                .toList() ??
            [];
}

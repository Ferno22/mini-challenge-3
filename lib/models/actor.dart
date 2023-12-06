/// Represents an actor with details such as ID, name, profile path, age, movies, and TV shows.
class Actor {
  /// Unique identifier for the actor.
  final int id;

  /// The name of the actor.
  final String name;

  /// The path to the actor's profile image.
  final String profilePath;

  /// The age of the actor, calculated based on the provided birthday in the JSON.
  final int age;

  /// List of movies in which the actor has appeared.
  final List<String> movies;

  /// List of TV shows in which the actor has appeared.
  final List<String> tvShows;

  /// Constructor for creating an instance of the [Actor] class.
  ///
  /// All parameters are required.
  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.age,
    required this.movies,
    required this.tvShows,
  });

  /// Constructor for creating an instance of the [Actor] class from JSON data.
  ///
  /// The [json] parameter contains general actor information, while [moviesJson]
  /// and [tvShowsJson] contain specific data about movies and TV shows in which
  /// the actor has appeared, respectively.
  Actor.fromJson(Map<String, dynamic> json, Map<String, dynamic> moviesJson,
      Map<String, dynamic> tvShowsJson)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        profilePath = json['profile_path'] ?? '',
        // Calculate the age based on the provided birthday in the JSON.
        age = DateTime.now().year - DateTime.parse(json['birthday']).year,
        // Extract the movie titles from the movies JSON data.
        movies = (moviesJson['cast'] as List<dynamic>?)
                ?.map((item) => item['title'] as String)
                .toList() ??
            [],
        // Extract the TV show names from the TV shows JSON data.
        tvShows = (tvShowsJson['cast'] as List<dynamic>?)
                ?.map((item) => item['name'] as String)
                .toList() ??
            [];
}

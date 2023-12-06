/// Represents a TV show with details such as ID, title, poster path, creators,
/// air dates, number of seasons and episodes, episode run time, overview, genres,
/// cast members, age suitability, production status, rating, and available streaming services.
class TVShow {
  /// Unique identifier for the TV show.
  final int id;

  /// The title of the TV show.
  final String title;

  /// The path to the TV show's poster image.
  final String posterPath;

  /// List of creators associated with the TV show.
  final List<Map<String, dynamic>> createdBy;

  /// The first air date of the TV show.
  final String firstAirDate;

  /// The last air date of the TV show.
  final String lastAirDate;

  /// The total number of seasons of the TV show.
  final int numberOfSeasons;

  /// The total number of episodes of the TV show.
  final int numberOfEpisodes;

  /// The run time of each episode in minutes.
  final List<int> episodeRunTime;

  /// A brief overview or description of the TV show.
  final String overview;

  /// List of genres associated with the TV show.
  final List<String> genres;

  /// List of cast members in the TV show.
  final List<String> castMembers;

  /// Indicates whether the TV show is for adults or not.
  final bool adult;

  /// Indicates whether the TV show is currently in production.
  final bool inProduction;

  /// The average rating of the TV show.
  final double rating;

  /// List of streaming services where the TV show is available.
  final List<String> providers;

  /// Constructor for creating an instance of the [TVShow] class.
  TVShow({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.createdBy,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.episodeRunTime,
    required this.overview,
    required this.genres,
    required this.castMembers,
    required this.adult,
    required this.inProduction,
    required this.rating,
    required this.providers,
  });

  /// Converts the [TVShow] object to a JSON format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'createdBy': createdBy,
      'firstAirDate': firstAirDate,
      'lastAirDate': lastAirDate,
      'numberOfSeasons': numberOfSeasons,
      'numberOfEpisodes': numberOfEpisodes,
      'episodeRunTime': episodeRunTime,
      'overview': overview,
      'genres': genres,
      'castMembers': castMembers,
      'adult': adult,
      'inProduction': inProduction,
      'rating': rating,
      'providers': providers,
    };
  }

  /// Calculates and returns the average episode run time as a list.
  List<String> get averageEpisodeRunTime {
    if (episodeRunTime.isEmpty) {
      return ['Not Available'];
    } else {
      int sum = episodeRunTime.reduce((a, b) => a + b);
      double average = sum / episodeRunTime.length;
      return [average.toStringAsFixed(2)];
    }
  }

  /// Returns a list of creator names associated with the TV show.
  List<String> get creatorNames {
    return createdBy.map((creator) => creator['name'] as String).toList();
  }

  /// Factory method for creating an instance of the [TVShow] class from JSON data.
  factory TVShow.fromJson(Map<String, dynamic> json,
      Map<String, dynamic> creditsJson, Map<String, dynamic> providersJson) {
    var createdByJson = json['created_by'] as List;
    List<Map<String, dynamic>> createdByList =
        createdByJson.map((i) => i as Map<String, dynamic>).toList();

    var episodeRunTimeJson = json['episode_run_time'] as List;
    List<int> episodeRunTimeList =
        episodeRunTimeJson.map((i) => i as int).toList();

    var genresJson = json['genres'] as List;
    List<String> genresList =
        genresJson.map((i) => i['name'] as String).toList();

    var castJson = creditsJson['cast'] as List;
    List<String> castList = castJson.map((i) => i['name'] as String).toList();

    var providerJson = providersJson['results']?['US']?['flatrate'] as List?;
    List<String> providersList = providerJson != null
        ? providerJson.map((i) => i['provider_name'] as String).toList()
        : [];
    return TVShow(
      id: json['id'] ?? 0,
      title: json['name'] ?? 'Not Available',
      posterPath: json['poster_path'] ?? '',
      createdBy: createdByList,
      firstAirDate: json['first_air_date'] ?? '',
      lastAirDate: json['last_air_date'] ?? '',
      numberOfSeasons: json['number_of_seasons'] ?? 0,
      numberOfEpisodes: json['number_of_episodes'] ?? 0,
      episodeRunTime: episodeRunTimeList,
      overview: json['overview'] ?? '',
      genres: genresList,
      castMembers: castList,
      adult: json['adult'] ?? false,
      inProduction: json['in_production'] ?? false,
      rating: json['vote_average'] ?? 0.0,
      providers: providersList,
    );
  }
}

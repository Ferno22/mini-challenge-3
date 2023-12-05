class TVShow {
  final int id;
  final String title;
  final String posterPath;
  final List<Map<String, dynamic>> createdBy;
  final String firstAirDate;
  final String lastAirDate;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final List<int> episodeRunTime;
  final String overview;
  final List<String> genres;
  final List<String> castMembers;
  final bool adult;
  final bool inProduction;
  final double rating;
  final List<String> providers;

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

  List<String> get averageEpisodeRunTime {
    if (episodeRunTime.isEmpty) {
      return ['Not Available'];
    } else {
      int sum = episodeRunTime.reduce((a, b) => a + b);
      double average = sum / episodeRunTime.length;
      return [average.toStringAsFixed(2)];
    }
  }

  List<String> get creatorNames {
    return createdBy.map((creator) => creator['name'] as String).toList();
  }

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

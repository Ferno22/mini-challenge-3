import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

/// Represents the user profile with details such as username, theme preference,
/// country, language, selected services, watchlist, and rated list.
class UserProfile extends ChangeNotifier {
  /// The singleton instance of the user profile.
  static UserProfile? _instance;

  /// The username of the user.
  String userName;

  /// Flag indicating whether the user prefers a dark theme.
  bool isDarkTheme;

  /// The country setting of the user.
  String country;

  /// The language setting of the user.
  String language;

  /// List of selected streaming services by the user.
  List<String> services;

  /// List of movies added to the user's watchlist.
  List<Map<String, dynamic>> watchlist;

  /// List of movies rated by the user.
  List<Map<String, dynamic>> ratedList;

  /// Constructor for creating an instance of the [UserProfile] class.
  ///
  /// The [userName] is optional and defaults to 'Default User'.
  UserProfile({
    this.userName = 'Default User',
    required this.isDarkTheme,
    required this.country,
    required this.language,
    required this.services,
    required this.watchlist,
    required this.ratedList,
  });

  /// Factory method to get the singleton instance of the user profile.
  static Future<UserProfile> getInstance() async {
    if (_instance == null) {
      _instance = await loadProfile();
    }
    return _instance!;
  }

  /// Method to save the user profile data to SharedPreferences.
  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
    prefs.setBool('isDarkTheme', isDarkTheme);
    prefs.setString('country', country);
    prefs.setString('language', language);
    prefs.setStringList('services', services);
    prefs.setString('watchlist', json.encode(watchlist));
    prefs.setString('ratedList', json.encode(ratedList));
    notifyListeners();
  }

  /// Method to load the user profile data from SharedPreferences.
  static Future<UserProfile> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return UserProfile(
      userName: prefs.getString('userName') ?? '',
      isDarkTheme: prefs.getBool('isDarkTheme') ?? false,
      country: prefs.getString('country') ?? '',
      language: prefs.getString('language') ?? '',
      services: prefs.getStringList('services') ?? [],
      watchlist: (json.decode(prefs.getString('watchlist') ?? '[]') as List)
          .map((item) => item as Map<String, dynamic>)
          .toList(),
      ratedList: (json.decode(prefs.getString('ratedList') ?? '[]') as List)
          .map((item) => item as Map<String, dynamic>)
          .toList(),
    );
  }

  /// Method to add a movie to the user's watchlist and save the updated list.
  Future<void> addToWatchlist(Map<String, dynamic> movie) async {
    watchlist.add(movie);
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'watchlist', watchlist.map((item) => json.encode(item)).toList());
  }
}

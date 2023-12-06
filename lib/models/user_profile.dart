import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class UserProfile extends ChangeNotifier {
  static UserProfile? _instance;

  String userName;
  bool isDarkTheme;
  String country;
  String language;
  List<String> services;
  List<Map<String, dynamic>> watchlist;
  List<Map<String, dynamic>> ratedList;

  UserProfile({
    required this.userName,
    required this.isDarkTheme,
    required this.country,
    required this.language,
    required this.services,
    required this.watchlist,
    required this.ratedList,
  });

  static Future<UserProfile> getInstance() async {
    if (_instance == null) {
      _instance = await loadProfile();
    }
    return _instance!;
  }

  // Method to save profile data
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

  // Method to load profile data
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

  // Method to add a movie to the watchlist
  Future<void> addToWatchlist(Map<String, dynamic> movie) async {
    watchlist.add(movie);
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'watchlist', watchlist.map((item) => json.encode(item)).toList());
  }
}

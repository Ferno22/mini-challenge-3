import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';

/// Widget for displaying and editing user settings.
class SettingsScreen extends StatefulWidget {
  /// The user profile associated with the current user.
  final UserProfile userProfile;

  /// Constructor that takes the user profile as a parameter.
  SettingsScreen({required this.userProfile});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _userName;
  late bool _isDarkTheme;
  late String _country;
  late String _language;
  late TmdbApi _api;
  late List<String> _countryNames;
  late List<String> _languages;
  late List<String> _services;

  @override
  void initState() {
    super.initState();
    _userName = widget.userProfile.userName;
    _isDarkTheme = widget.userProfile.isDarkTheme;
    _country = widget.userProfile.country;
    _language = widget.userProfile.language;
    _services = widget.userProfile.services;
    _api = TmdbApi();
    _countryNames = [];
    _languages = [];
    _services = [
      'Netflix',
      'Disney+',
      'Hulu',
      'Prime Video',
      'HBO Max',
      'Apple TV+',
      'Peacock',
      'Paramount+',
      'Starz',
      'Showtime',
      'Discovery+',
      'IMDb TV',
      'The Roku Channel',
      'Pluto TV',
      'Tubi',
      'Vudu',
      'FandangoNOW',
      'Sling TV',
      'YouTube Premium',
      'Hoopla',
      'Criterion Channel',
    ];
    _api.getCountries().then((value) {
      setState(() {
        _countryNames = value;
      });
    });
    _api.getLanguages().then((value) {
      setState(() {
        _languages = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('User Name'),
            subtitle: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: _userName),
                    onChanged: (value) {
                      _userName = value;
                    },
                    onSubmitted: (value) {
                      widget.userProfile.userName = _userName;
                      widget.userProfile.saveProfile();
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    widget.userProfile.userName = _userName;
                    widget.userProfile.saveProfile();
                  },
                ),
              ],
            ),
          ),
          SwitchListTile(
            title: Text('Dark Theme'),
            value: _isDarkTheme,
            onChanged: (bool value) {
              setState(() {
                _isDarkTheme = value;
                widget.userProfile.isDarkTheme = value;
                widget.userProfile.saveProfile();
              });
            },
          ),
          Text('Countries', style: TextStyle(fontSize: 18)),
          // Add dropdowns for countries based on the output of the getCountries() method
          DropdownButton<String>(
            value: _country.isNotEmpty
                ? _country
                : null, // Set value to null if empty
            hint: Text('$_country'),
            onChanged: (String? newValue) {
              setState(() {
                _country = newValue ?? ''; // Set to empty string if null
                widget.userProfile.country = _country;
              });
            },
            items: _countryNames.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Text('Languages', style: TextStyle(fontSize: 18)),
          // Add dropdowns for languages based on the output of the getLanguages() method
          DropdownButton<String>(
            value: _language.isNotEmpty
                ? _language
                : null, // Set value to null if empty
            hint: Text('$_language'),
            onChanged: (String? newValue) {
              setState(() {
                _language = newValue ?? ''; // Set to empty string if null
                widget.userProfile.language = _language;
              });
            },
            items: _languages.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          // Add checkboxes for service selection
          Text('Services', style: TextStyle(fontSize: 18)),
          Column(
            children: _services
                .map((service) => CheckboxListTile(
                      title: Text(service),
                      value: widget.userProfile.services.contains(service),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null) {
                            if (value) {
                              widget.userProfile.services.add(service);
                            } else {
                              widget.userProfile.services.remove(service);
                            }
                            widget.userProfile.saveProfile();
                          }
                        });
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

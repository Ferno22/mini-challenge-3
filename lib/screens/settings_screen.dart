import 'package:flutter/material.dart';
import 'package:mini_challenge_3/models/user_profile.dart';
import 'package:mini_challenge_3/api/tmdb_api.dart';

class SettingsScreen extends StatefulWidget {
  final UserProfile userProfile;
  SettingsScreen({required this.userProfile});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _userName;
  late bool _isDarkTheme;
  late String _country;
  late String _language;
  late List<String> _services;
  late List<String> _languages;

  @override
  void initState() {
    super.initState();
    _userName = widget.userProfile.userName;
    _isDarkTheme = widget.userProfile.isDarkTheme;
    _country = widget.userProfile.country;
    _language = widget.userProfile.language;
    _services = widget.userProfile.services;
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
          // Add dropdowns for country and language selection
          // Add checkboxes for service selection
        ],
      ),
    );
  }
}

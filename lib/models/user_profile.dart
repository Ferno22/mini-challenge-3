class UserProfile {
  final String username;
  final bool isDarkMode;
  final String selectedLanguage;
  final List<String> subscribedServices;

  UserProfile({
    required this.username,
    required this.isDarkMode,
    required this.selectedLanguage,
    required this.subscribedServices,
  });
}

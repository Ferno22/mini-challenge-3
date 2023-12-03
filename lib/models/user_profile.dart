// This class represents a user profile.
class UserProfile {
  // This is the username of the user.
  final String username;

  // This boolean value represents whether the user has selected dark mode or not.
  final bool isDarkMode;

  // This string represents the language selected by the user.
  final String selectedLanguage;

  // This list contains the services the user is subscribed to (e.g., Netflix).
  final List<String> subscribedServices;

  // This is the constructor for the UserProfile class.
  UserProfile({
    // This is the username of the user.
    required this.username,

    // This boolean value represents whether the user has selected dark mode or not.
    required this.isDarkMode,

    // This string represents the language selected by the user.
    required this.selectedLanguage,

    // This list contains the services the user is subscribed to (e.g., Netflix).
    required this.subscribedServices,
  });
}

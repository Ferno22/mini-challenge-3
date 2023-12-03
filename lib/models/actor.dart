// This is the updated Actor class. It now includes the actor's age and a list of movies/shows they appear in.
class Actor {
  final int id;
  final String name;
  final String profilePath;
  // The actor's age.
  final int age;
  // A list of movies/shows the actor appears in.
  final List<String> filmography;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.age,
    required this.filmography,
  });
}

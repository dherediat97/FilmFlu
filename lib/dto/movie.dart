class Movie {
  final String title;
  final String subtitle;

  const Movie({required this.title, required this.subtitle});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["title"],
      subtitle: json["subtitle"],
    );
  }
}

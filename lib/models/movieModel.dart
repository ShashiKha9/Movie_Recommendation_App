class MovieModel {
  final List<String> genres;
  final String id;
  final String name;

  MovieModel({
    required this.genres,
    required this.id,
    required this.name,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // Remove single quotes and split the string into a List

    List<String> genresList = (json['Genres'] as String).replaceAll("'", "").split(', ');

    return MovieModel(
      genres: genresList,
      id: json['Id'],
      name: json['Name'],
    );
  }
}

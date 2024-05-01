import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.title,
    required super.releaseDate,
    required super.posterPath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'release_date': releaseDate,
      'poster_path': posterPath,
    };
  }
}

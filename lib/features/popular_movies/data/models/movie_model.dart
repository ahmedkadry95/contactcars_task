import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.releaseDate,
    required super.posterPath,
    required super.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? 'N/A',
      releaseDate: json['release_date'] ?? 'N/A',
      posterPath: json['poster_path'] ?? 'N/A',
      voteAverage: json['vote_average'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'release_date': releaseDate,
      'poster_path': posterPath,
      'vote_average': voteAverage,
    };
  }
}

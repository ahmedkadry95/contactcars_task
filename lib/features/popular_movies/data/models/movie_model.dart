import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.releaseDate,
    required super.posterPath,
    required super.voteAverage,
    required super.overview,
    required super.genreIds,
    required super.backdropPath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      releaseDate: json['release_date'] ?? '',
      posterPath: json['poster_path'] ?? '',
      voteAverage: json['vote_average'] ?? 0.0,
      overview: json['overview'] ?? '',
      genreIds:
          json['genre_ids'] != null ? List<int>.from(json['genre_ids']) : [],
      backdropPath: json['backdrop_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'release_date': releaseDate,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'overview': overview,
      'genreIds': genreIds,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
    };
  }
}

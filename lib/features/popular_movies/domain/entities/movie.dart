import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String releaseDate;
  final String posterPath;

  const Movie({
    required this.title,
    required this.releaseDate,
    required this.posterPath,
  });

  @override
  List<Object?> get props => [title, releaseDate, posterPath];
}

import 'package:hive/hive.dart';

class Movie extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String releaseDate;
  @HiveField(3)
  final String posterPath;
  @HiveField(4)
  final double voteAverage;

  Movie({
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.voteAverage,
    required this.id,
  });
}

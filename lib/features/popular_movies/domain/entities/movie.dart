import 'package:hive/hive.dart';

class Movie extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String releaseDate;
  @HiveField(2)
  final String posterPath;

  Movie({
    required this.title,
    required this.releaseDate,
    required this.posterPath,
  });
}

import 'package:contactcars_task/features/popular_movies/domain/entities/genre.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:contactcars_task/features/popular_movies/presentation/widgets/movie_details_data.dart';
import 'package:contactcars_task/features/popular_movies/presentation/widgets/movie_details_header.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatelessWidget {
  late Movie movie;
  late List<Genre> genre;

  MovieDetails({
    super.key,
    required this.movie,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MovieDetailsHeader(movie: movie),
          MovieDetailsData(movie: movie, genre: genre)
        ],
      ),
    );
  }
}

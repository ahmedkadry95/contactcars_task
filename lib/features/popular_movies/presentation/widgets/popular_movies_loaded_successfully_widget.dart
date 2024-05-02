import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/utilis/spaces/spaces.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:contactcars_task/features/popular_movies/presentation/widgets/movie_card.dart';
import 'package:contactcars_task/features/popular_movies/presentation/widgets/popular_movies_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularMoviesLoadedSuccessfullyWidget extends StatelessWidget {
  PopularMoviesLoadedSuccessfullyWidget({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;
  PopularMoviesCubit cubit = di<PopularMoviesCubit>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: movies[index],
                    onTap: () {
                      cubit.selectedMovieIndex = index;
                      cubit.checkMovieGenres(
                        context: context,
                        genreIds: movies[index].genreIds,
                        movies: movies,
                      );
                    },
                  );
                },
              ),
            ),
            PopularMoviesButtons(cubit: cubit),
            heightSpace(20.sp)
          ],
        ),
      ],
    );
  }
}

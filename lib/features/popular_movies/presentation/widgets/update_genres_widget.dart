import 'package:contactcars_task/core/shaerd_widgets/loading_card.dart';
import 'package:contactcars_task/core/utilis/spaces/spaces.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:contactcars_task/features/popular_movies/presentation/widgets/movie_card.dart';
import 'package:contactcars_task/features/popular_movies/presentation/widgets/popular_movies_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateGenresWidget extends StatelessWidget {
  const UpdateGenresWidget({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

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
                      context.read<PopularMoviesCubit>().checkMovieGenres(
                            context: context,
                            genreIds: movies[index].genreIds,
                            movies: movies,
                          );
                    },
                  );
                },
              ),
            ),
            PopularMoviesButtons(cubit: context.read<PopularMoviesCubit>()),
            heightSpace(20.sp)
          ],
        ),
        LoadingCard(),
      ],
    );
  }
}

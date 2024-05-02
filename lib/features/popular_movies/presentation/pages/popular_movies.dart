import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:contactcars_task/features/popular_movies/presentation/widgets/no_cashed_popular_movie_exsit.dart';
import 'package:contactcars_task/features/popular_movies/presentation/widgets/popular_movies_loaded_successfully_widget.dart';
import 'package:contactcars_task/features/popular_movies/presentation/widgets/some_thing_went_wrong_widget.dart';
import 'package:contactcars_task/features/popular_movies/presentation/widgets/update_genres_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({super.key});

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  PopularMoviesCubit cubit = di<PopularMoviesCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getPopularMovies(pageNumber: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
        builder: (context, state) {
          if (state is PopularMoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularMoviesLoadedSuccessfully) {
            return PopularMoviesLoadedSuccessfullyWidget(
              movies: state.movies,
            );
          }
          if (state is UpdateGenres) {
            return UpdateGenresWidget(
              movies: state.movies,
            );
          } else if (state is PopularMoviesLoadedFailed) {
            return UnkownErrorWidget();
          } else if (state is NoCashedPopularMoviesExist) {
            return NoCashedPopularMoviesExistWidget(
              message: state.message,
            );
          }
          return UnkownErrorWidget();
        },
      ),
    );
  }
}

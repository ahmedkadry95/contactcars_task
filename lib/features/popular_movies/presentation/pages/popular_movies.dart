import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PopularMoviesCubit, PopularMoviesState>(
        listener: (context, state) {
          print('=================================');
          print('=================================');
          print('=================================');
          print('=================================');
          print('=================================');
          print(state);
          if (state is PopularMoviesLoading) {
            print('Loading');
          }
        },
        builder: (context, state) {
          return Container();
        },
      ),
    );
  }
}

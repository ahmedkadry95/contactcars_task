import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/theming/buttons_styles.dart';
import 'package:contactcars_task/core/theming/styles.dart';
import 'package:contactcars_task/core/utilis/spaces/spaces.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:contactcars_task/features/popular_movies/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({super.key});

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  late PopularMoviesCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = di<PopularMoviesCubit>();
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
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return MovieCard(movie: state.movies[index]);
                    },
                  ),
                ),
                PopularMoviesButtons(cubit: cubit)
              ],
            );
          } else if (state is PopularMoviesLoadedFailed) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          } else if (state is NoCashedPopularMoviesExist) {
            return NoCashedPopularMoviesExistWidget(
              message: state.message,
            );
          }
          return const Center(
            child: Text('Something went wrong!'),
          );
        },
      ),
    );
  }
}

class NoCashedPopularMoviesExistWidget extends StatelessWidget {
  String message;
  PopularMoviesCubit cubit = di<PopularMoviesCubit>();

  NoCashedPopularMoviesExistWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    print('${cubit.pageNumber} cubit.pageNumber');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            message,
            style: TextStyles.font22SemiBoldBlack,
            textAlign: TextAlign.center,
          ),
        ),
        heightSpace(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (cubit.pageNumber != 1)
              ElevatedButton(
                onPressed: () {
                  cubit.getPopularMovies(
                    isNext: false,
                    pageNumber: cubit.pageNumber - 1,
                  );
                },
                style: mainAppButtonStyle,
                child: const Text('Previous'),
              ),
            ElevatedButton(
              onPressed: () {
                cubit.getPopularMovies(pageNumber: cubit.pageNumber);
              },
              style: mainAppButtonStyle,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ],
    );
  }
}

////////////////////////////    Popular Movies Buttons          ////////////////////////////
////////////////////////////    Popular Movies Buttons          ////////////////////////////
////////////////////////////    Popular Movies Buttons          ////////////////////////////
////////////////////////////    Popular Movies Buttons          ////////////////////////////

class PopularMoviesButtons extends StatelessWidget {
  const PopularMoviesButtons({
    super.key,
    required this.cubit,
  });

  final PopularMoviesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (cubit.pageNumber > 1)
            ElevatedButton(
              style: mainAppButtonStyle,
              onPressed: () {
                cubit.getPopularMovies(
                  isNext: false,
                  pageNumber: cubit.pageNumber - 1,
                );
              },
              child: const Text('Previous'),
            ),
          ElevatedButton(
            style: mainAppButtonStyle,
            onPressed: () {
              cubit.getPopularMovies(pageNumber: cubit.pageNumber + 1);
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

import 'package:contactcars_task/core/theming/buttons_styles.dart';
import 'package:contactcars_task/core/theming/styles.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:flutter/material.dart';

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
              style: mainAppButtonStyle(context: context),
              onPressed: () {
                cubit.getPopularMovies(
                  isNext: false,
                  pageNumber: cubit.pageNumber - 1,
                );
              },
              child: const Text('Previous'),
            ),
          Text(
            cubit.pageNumber.toString(),
            style: TextStyles.font15BoldMainColor,
          ),
          ElevatedButton(
            style: mainAppButtonStyle(context: context),
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

import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/theming/buttons_styles.dart';
import 'package:contactcars_task/core/theming/styles.dart';
import 'package:contactcars_task/core/utilis/spaces/spaces.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoCashedPopularMoviesExistWidget extends StatelessWidget {
  String message;
  PopularMoviesCubit cubit = di<PopularMoviesCubit>();

  NoCashedPopularMoviesExistWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              message,
              style: TextStyles.font20SemiBoldBlack,
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
                  style: mainAppButtonStyle(context: context),
                  child: const Text('Previous'),
                ),
              ElevatedButton(
                onPressed: () {
                  cubit.checkInternetConnection(context);
                },
                style: mainAppButtonStyle(context: context),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/utilis/spaces/spaces.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnkownErrorWidget extends StatelessWidget {
  PopularMoviesCubit cubit = di<PopularMoviesCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Something went wrong!'),
        heightSpace(20.h),
        ElevatedButton(
          onPressed: () {
            cubit.checkInternetConnection(context);
          },
          child: const Text('Try Again'),
        ),
      ],
    );
  }
}

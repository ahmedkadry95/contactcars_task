import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/core/theming/buttons_styles.dart';
import 'package:contactcars_task/core/theming/styles.dart';
import 'package:contactcars_task/core/utilis/spaces/spaces.dart';
import 'package:contactcars_task/features/popular_movies/presentation/cubit/popular_movies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnkownErrorWidget extends StatelessWidget {
  PopularMoviesCubit cubit = di<PopularMoviesCubit>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Something went wrong!',
            style: TextStyles.font20SemiBoldBlack,
          ),
          heightSpace(20.h),
          ElevatedButton(
            onPressed: () {
              cubit.checkInternetConnection(context);
            },
            style: mainAppButtonStyle(context: context),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}

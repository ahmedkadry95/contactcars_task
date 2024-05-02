import 'package:contactcars_task/core/theming/colors.dart';
import 'package:contactcars_task/core/theming/styles.dart';
import 'package:contactcars_task/core/utilis/spaces/spaces.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/genre.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MovieDetailsData extends StatelessWidget {
  const MovieDetailsData({
    super.key,
    required this.movie,
    required this.genre,
  });

  final Movie movie;
  final List<Genre> genre;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ListTile(
            title: Text(movie.title, style: TextStyles.font20SemiBoldBlack),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'User Score : ',
                      style: TextStyles.font15SemiBoldBlack,
                    ),
                    CircularPercentIndicator(
                      radius: 18.0,
                      lineWidth: 3.0,
                      percent: movie.voteAverage / 10,
                      center: Text(movie.voteAverage.toStringAsFixed(1)),
                      progressColor: ColorsManager.greenColor,
                      backgroundColor: ColorsManager.mainColor,
                    )
                  ],
                ),
                heightSpace(10.sp),
                Text(
                  movie.overview.isEmpty ? 'Overview Not Add' : movie.overview,
                  style: TextStyles.font13SemiBoldGrey,
                ),
                heightSpace(10.sp),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Release Date : ',
                        style: TextStyles.font15BoldMainColor,
                      ),
                      TextSpan(
                        text: movie.releaseDate.isEmpty
                            ? 'Release Date Not Add'
                            : movie.releaseDate,
                        style: TextStyles.font13SemiBoldBlack,
                      ),
                    ],
                  ),
                ),
                heightSpace(10.sp),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Movie Genres : ',
                        style: TextStyles.font15BoldMainColor,
                      ),
                      if (genre.isNotEmpty)
                        TextSpan(
                          text: genre.map((e) => e.name).join(', '),
                          style: TextStyles.font13SemiBoldBlack,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

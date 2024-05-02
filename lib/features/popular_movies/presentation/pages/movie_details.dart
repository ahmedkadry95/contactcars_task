import 'package:contactcars_task/core/extensions/media_query/media_query.dart';
import 'package:contactcars_task/core/shaerd_widgets/app_cashed_image.dart';
import 'package:contactcars_task/core/theming/colors.dart';
import 'package:contactcars_task/core/theming/styles.dart';
import 'package:contactcars_task/core/utilis/spaces/spaces.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/genre.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MovieDetails extends StatelessWidget {
  late Movie movie;
  late List<Genre> genre;

  MovieDetails({
    super.key,
    required this.movie,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MovieDetailsHeader(movie: movie),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title:
                      Text(movie.title, style: TextStyles.font20SemiBoldBlack),
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
                        movie.overview.isEmpty
                            ? 'Overview Not Add'
                            : movie.overview,
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
          )
        ],
      ),
    );
  }
}

///////
///////
///////
///////
class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.38,
      child: Stack(
        children: [
          AppCashedImage(
            height: context.height * 0.3,
            width: context.width,
            imageUrl: movie.backdropPath,
          ),
          Positioned(
            top: context.height * 0.05,
            right: 20,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              elevation: 10,
              child: Hero(
                tag: 'poster${movie.id}',
                child: AppCashedImage(
                  width: context.width * 0.35,
                  height: context.height * 0.30,
                  imageUrl: movie.posterPath,
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 20,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.arrow_back),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

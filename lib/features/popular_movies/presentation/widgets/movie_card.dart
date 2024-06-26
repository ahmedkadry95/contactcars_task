import 'package:cached_network_image/cached_network_image.dart';
import 'package:contactcars_task/core/constants/strings/constant_strings.dart';
import 'package:contactcars_task/core/theming/colors.dart';
import 'package:contactcars_task/core/theming/styles.dart';
import 'package:contactcars_task/features/popular_movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  void Function() onTap;

  MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: ColorsManager.white,
        elevation: 3,
        surfaceTintColor: ColorsManager.mainColor,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'poster${movie.id}',
              child: CachedNetworkImage(
                width: 90.sp,
                height: 110.sp,
                imageUrl: AppStrings.imageBaseUrl + movie.posterPath,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                placeholder: (context, url) => SizedBox(
                  width: 100.sp,
                  height: 120.sp,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => SizedBox(
                  width: 100.sp,
                  height: 120.sp,
                  child: const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  movie.title,
                  style: TextStyles.font15BoldMainColor,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  movie.releaseDate,
                  style: TextStyles.font13SemiBoldGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

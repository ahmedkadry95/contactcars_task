import 'package:cached_network_image/cached_network_image.dart';
import 'package:contactcars_task/core/constants/strings/constant_strings.dart';
import 'package:contactcars_task/core/utilis/loading/loading.dart';
import 'package:flutter/material.dart';

class AppCashedImage extends StatelessWidget {
  double height;
  double width;
  String imageUrl;

  AppCashedImage({
    super.key,
    required this.height,
    required this.width,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: AppStrings.imageBaseUrl + imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        width: width,
        height: height,
        child: const AppLoading(),
      ),
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        child: const Icon(Icons.error),
      ),
    );
  }
}

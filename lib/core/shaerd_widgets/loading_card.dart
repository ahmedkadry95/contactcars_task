import 'dart:io';

import 'package:contactcars_task/core/theming/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          color: Colors.black.withOpacity(0.5),
        ),
        padding: EdgeInsets.all(20.sp),
        child: Platform.isAndroid
            ? const CircularProgressIndicator(
                color: ColorsManager.white,
              )
            : const CupertinoActivityIndicator(
                color: ColorsManager.mainColor,
              ),
      ),
    );
  }
}

import 'package:contactcars_task/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var mainAppButtonStyle = ElevatedButton.styleFrom(
  maximumSize:  Size(110.sp, 55.sp),
  minimumSize:  Size(110.sp, 55.sp),
  foregroundColor: ColorsManager.white,
  backgroundColor: ColorsManager.mainColor,
  padding: const EdgeInsets.symmetric(
    horizontal: 30,
    vertical: 15,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);

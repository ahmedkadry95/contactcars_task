import 'package:contactcars_task/core/constants/strings/constant_strings.dart';
import 'package:contactcars_task/core/theming/colors.dart';
import 'package:contactcars_task/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle font22SemiBoldBlack = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.light,
    color: ColorsManager.black,
    fontFamily: AppStrings.enFontFamily,
  );
  static TextStyle font15BoldBlack = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.secondaryAppColor,
    fontFamily: AppStrings.enFontFamily,
  );

  static TextStyle font13SemiBoldGrey = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: ColorsManager.grey,
    fontFamily: AppStrings.enFontFamily,
  );
}

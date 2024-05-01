import 'package:contactcars_task/core/theming/colors.dart';
import 'package:contactcars_task/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle font22BoldSecondaryAppColor = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.secondaryAppColor,
  );
  static TextStyle font20BoldSecondaryAppColor = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.secondaryAppColor,
  );

  static TextStyle font16SimiBoldSecondaryAppColor = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: ColorsManager.secondaryAppColor,
  );
}

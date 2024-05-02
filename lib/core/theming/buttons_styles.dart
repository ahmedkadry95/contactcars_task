import 'package:contactcars_task/core/extensions/media_query/media_query.dart';
import 'package:contactcars_task/core/theming/colors.dart';
import 'package:flutter/material.dart';

ButtonStyle mainAppButtonStyle({required BuildContext context}) {
  return ElevatedButton.styleFrom(
    minimumSize: Size(context.width * .35, 50),
    maximumSize: Size(context.width * .35, 50),
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
}

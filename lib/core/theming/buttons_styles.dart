import 'package:contactcars_task/core/theming/colors.dart';
import 'package:flutter/material.dart';

var mainAppButtonStyle = ElevatedButton.styleFrom(
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

import 'dart:io' show Platform;

import 'package:contactcars_task/core/theming/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? const CircularProgressIndicator(
              color: ColorsManager.mainColor,
            )
          : const CupertinoActivityIndicator(
              color: ColorsManager.mainColor,
            ),
    );
  }
}

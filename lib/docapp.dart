import 'package:contactcars_task/core/constants/strings/constant_strings.dart';
import 'package:contactcars_task/core/routing/app_router.dart';
import 'package:contactcars_task/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/routs.dart';

class TaskApp extends StatelessWidget {
  final AppRouter appRouter;

  const TaskApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Contact Cars Task',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              fontFamily: AppStrings.enFontFamily,
            ),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: ColorsManager.mainColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}

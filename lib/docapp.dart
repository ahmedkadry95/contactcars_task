import 'package:contactcars_task/core/routing/app_router.dart';
import 'package:contactcars_task/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/routs.dart';

class DocApp extends StatelessWidget {
  final AppRouter appRouter;

  const DocApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Contact Cars Task',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            surfaceTintColor: ColorsManager.mainColor,
            elevation: 0,
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

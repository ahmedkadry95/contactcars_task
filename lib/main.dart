import 'package:contactcars_task/core/di/di.dart';
import 'package:contactcars_task/docapp.dart';
import 'package:flutter/material.dart';

import 'core/routing/app_router.dart';

void main() async {
  setupDependencyInjection();
  runApp(
    DocApp(
      appRouter: AppRouter(),
    ),
  );
}

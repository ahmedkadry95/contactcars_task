import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension NavigationHelper on BuildContext {
  push(Widget page) {
    return Navigator.of(this).push(
      FadePageRoute(builder: (context) => page),
    );
  }

  pushWithNamed(String pageRoute, {Object? arguments}) {
    return Navigator.of(this).pushNamed(
      pageRoute,
      arguments: arguments,
    );
  }

  pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(
      FadePageRoute(
        builder: (context) => page,
      ),
    );
  }

  pushReplacementWithCubit(
    Widget page, {
    required Cubit cubit,
  }) {
    Navigator.of(this).pushReplacement(
      FadePageRoute(
        builder: (context) => BlocProvider(
          create: (context) => cubit,
          child: page,
        ),
      ),
    );
  }

  pushReplacementWithNamed(String pageRoute, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(
      pageRoute,
      arguments: arguments,
    );
  }

  pushAndRemoveUntil(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      FadePageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  pushAndRemoveUntilWithNamed(String pageRoute, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(pageRoute, (route) => false,
        arguments: arguments);
  }

  pop() {
    Navigator.of(this).pop();
  }
// pushWithoutNavBar(Widget page){
//   PersistentNavBarNavigator.pushDynamicScreen(
//     this,
//     screen:   FadePageRoute(builder: (context) => page),
//     withNavBar: false,
//   );
//
// }
}
//////////////////////////////
//////////////////////////////
/////// animation class///////
//////////////////////////////
//////////////////////////////

class FadePageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;

  FadePageRoute({required this.builder})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              builder(context),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

class SlidePageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;

  SlidePageRoute({required this.builder})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              builder(context),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class ScalePageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;

  ScalePageRoute({required this.builder})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              builder(context),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          ),
        );
}

///
///
Route createRoute({
  required Widget page,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

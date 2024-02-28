import 'package:flutter/material.dart';

abstract class RouteInfo {
  final WidgetBuilder builder;
  final bool fullScreenDialog;
  final bool authRequired;

  const RouteInfo({required this.builder, this.fullScreenDialog = false, this.authRequired = true});

  Route call(RouteSettings settings);
}

class MaterialRouteInfo extends RouteInfo {
  const MaterialRouteInfo({required super.builder, super.authRequired, super.fullScreenDialog});

  @override
  Route call(RouteSettings settings) {
    return MaterialPageRoute<Object?>(
      builder: builder,
      settings: settings,
      fullscreenDialog: fullScreenDialog,
    );
  }
}

class FadeRouteInfo extends RouteInfo {
  const FadeRouteInfo({required super.builder, super.authRequired, super.fullScreenDialog});

  @override
  Route call(RouteSettings settings) {
    return PageRouteBuilder<Object?>(
      pageBuilder: (context, animation, _) => builder(context),
      settings: settings,
      fullscreenDialog: fullScreenDialog,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

class SlideRouteInfo extends RouteInfo {
  SlideRouteInfo({required super.builder});

  @override
  Route call(RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, _) => builder(context),
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
}

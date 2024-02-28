import 'package:bit_merge_mobile/packages/core/core.dart';
import 'package:bit_merge_mobile/src/app/route/route_info.dart';
import 'package:bit_merge_mobile/src/ui/auth/auth_view.dart';
import 'package:bit_merge_mobile/src/ui/home/home_view.dart';
import 'package:bit_merge_mobile/src/ui/splash/splash_view.dart';
import 'package:flutter/material.dart';

class AppRouteGenerator {
  /* final AppPreference preference;

  AppRouteGenerator({required this.preference});*/

  Route? onGenerateRoute(RouteSettings settings) {
    Log.debug("${settings.name} -> ${settings.arguments}");
    var routeName = settings.name;

    var routeInfo = _routes[routeName];
    if (routeInfo == null) return null;

    /* if (routeInfo.authRequired && !pref.isLogin) {
      return _routes[LoginView.routeName]?.call(const RouteSettings(name: LoginView.routeName));
    }*/
    return routeInfo(settings);
  }

  final Map<String, RouteInfo> _routes = {
    SplashView.routeName: const FadeRouteInfo(builder: SplashView.builder),
    AuthView.routeName: const FadeRouteInfo(builder: AuthView.builder),
    HomeView.routeName: const FadeRouteInfo(builder: HomeView.builder),
  };
}

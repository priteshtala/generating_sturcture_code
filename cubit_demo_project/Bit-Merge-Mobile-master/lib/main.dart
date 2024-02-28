import 'package:bit_merge_mobile/src/app/app.dart';
import 'package:flutter/material.dart';

import 'bootstrap.dart';

void main() {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bootstrap(
    () => BitMergeApp(navigatorKey: navigatorKey),
    // blocObserver: AppBlocObserver(navigatorKey: navigatorKey),
  );
}

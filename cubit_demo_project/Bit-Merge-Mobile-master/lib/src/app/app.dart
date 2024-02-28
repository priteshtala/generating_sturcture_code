import 'package:bit_merge_mobile/packages/resources/resources.dart';
import 'package:bit_merge_mobile/src/app/route/routes.dart';
import 'package:bit_merge_mobile/src/l10n/l10n.dart';
import 'package:bit_merge_mobile/src/ui/splash/splash_view.dart';
import 'package:bit_merge_mobile/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dependency.dart';
import 'localization/localization_cubit.dart';

class BitMergeApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const BitMergeApp({super.key, required this.navigatorKey});

  @override
  State<BitMergeApp> createState() => _BitMergeAppState();
}

class _BitMergeAppState extends State<BitMergeApp> {
  final DependencyHelper _dependencyHelper = DependencyHelper.getInstance();
  late final _routeObserver = _dependencyHelper<RouteObserver>();
  late final _appRoutes = AppRouteGenerator(/*preference: _dependencyHelper<AppPreference>()*/);

  String get initialRoute {
    return SplashView.routeName;
  }

  @override
  Widget build(BuildContext context) {
    final themeState = BlocProvider.of<ThemeBloc>(context, listen: true).state;
    final language = context.select<LocalizationCubit, Language>((value) => value.state.selectedLanguage);
    return MaterialApp(
      restorationScopeId: 'Bit Merge App',
      onGenerateTitle: (context) => context.l10n.appName,
      navigatorKey: widget.navigatorKey,
      navigatorObservers: [_routeObserver],
      onGenerateRoute: _appRoutes.onGenerateRoute,
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      themeMode: themeState.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: Locale(language.languageCode),
      supportedLocales: BitMergeLocalization.delegate.supportedLocales,
      localizationsDelegates: const [
        BitMergeLocalization.delegate,
        BitMergeLocalization.delegate,
        BitMergeLocalization.delegate,
        BitMergeLocalization.delegate,
      ],
    );
  }
}

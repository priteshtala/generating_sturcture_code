import 'dart:async';

import 'package:bit_merge_mobile/packages/utils/firebase_helper.dart';
import 'package:bit_merge_mobile/src/l10n/generated/l10n.dart';
import 'package:bit_merge_mobile/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'packages/data/data.dart';
import 'src/app/dependency.dart';
import 'src/app/localization/localization_cubit.dart';
import 'src/app/user/user_cubit.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
) async {
  return runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    DependencyHelper dependencyHelper = DependencyHelper.getInstance();
    await dependencyHelper.initialize();
    final firebaseHelper = FirebaseHelper();
    await firebaseHelper.initializeApp();

    // Set system ui appearance & behaviours for app
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
        systemStatusBarContrastEnforced: false,
      ),
    );
    final preference = dependencyHelper<AppPreference>();
    final userState = UserState(isLogin: preference.isLogin);

    return runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => dependencyHelper<AuthRepository>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(themeMode: preference.themeMode),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => UserCubit(context, userState),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => LocalizationCubit.fromSystem(
              localizationsDelegate: BitMergeLocalization.delegate,
              preference: preference,
            ),
          ),
        ],
        child: await builder(),
      ),
    ));
  }, (error, stackTrace) {
    // Log.error(error);
    // Log.error(stackTrace);
  });
}

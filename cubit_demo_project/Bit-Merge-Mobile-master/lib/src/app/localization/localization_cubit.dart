import 'package:bit_merge_mobile/packages/data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit(
    super.initialState, {
    required this.localizationsDelegate,
    required this.preference,
  });

  final LocalizationsDelegate localizationsDelegate;
  final AppPreference preference;

  factory LocalizationCubit.fromSystem({
    required LocalizationsDelegate localizationsDelegate,
    required AppPreference preference,
  }) {
    Locale? effectiveLocale;

    final languageCodes = [preference.currentLanguageCode, PlatformDispatcher.instance.locale.languageCode];

    for (var languageCode in languageCodes) {
      if (languageCode != null) {
        final locale = Locale.fromSubtags(languageCode: languageCode);
        if (localizationsDelegate.isSupported(locale)) {
          effectiveLocale = locale;
          break;
        }
      }
    }

    effectiveLocale ??= const Locale('en');
    final selectedLanguage =
        Language.values.where((element) => element.languageCode == effectiveLocale?.languageCode).firstOrNull;

    return LocalizationCubit(
      LocalizationState(selectedLanguage: selectedLanguage ?? Language.english),
      localizationsDelegate: localizationsDelegate,
      preference: preference,
    );
  }

  static LocalizationCubit of(BuildContext context, [bool listen = false]) {
    return BlocProvider.of<LocalizationCubit>(context, listen: listen);
  }

  void onLocalizationUpdated({required Language language}) {
    final locale = Locale.fromSubtags(languageCode: language.languageCode);
    bool isSupported = localizationsDelegate.isSupported(locale);
    if (!isSupported) return;
    emit(state.copyWith(selectedLanguage: language));
    preference.currentLanguageCode = language.languageCode;
  }
}

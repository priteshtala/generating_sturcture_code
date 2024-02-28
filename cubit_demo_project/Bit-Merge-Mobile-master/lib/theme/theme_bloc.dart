import 'dart:async';

import 'package:bit_merge_mobile/theme/theme_event.dart';
import 'package:bit_merge_mobile/theme/theme_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({ThemeMode? themeMode}) : super(ThemeState(themeMode: themeMode ?? ThemeMode.system)) {
    on<ThemeChanged>(_onThemeChanged);
    on<ThemeUpdated>(_onThemeUpdated);
    if (themeMode == ThemeMode.system) {
      Timer.run(_onPlatformBrightnessChanged);
      WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = _onPlatformBrightnessChanged;
    }
  }

  void _onPlatformBrightnessChanged() {
    add(ThemeUpdated(brightness: WidgetsBinding.instance.platformDispatcher.platformBrightness));
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    Brightness? brightness;
    switch (event.themeMode) {
      case ThemeMode.system:
        if (state.themeMode != ThemeMode.system) {
          WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = _onPlatformBrightnessChanged;
        }
        brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        break;
      case ThemeMode.light:
        if (state.themeMode == ThemeMode.system) {
          WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = null;
        }
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        if (state.themeMode == ThemeMode.system) {
          WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = null;
        }
        brightness = Brightness.dark;
        break;
    }
    emit(state.copyWith(brightness: brightness, themeMode: state.themeMode));
  }

  void _onThemeUpdated(ThemeUpdated event, Emitter<ThemeState> emit) {
    emit(state.copyWith(brightness: event.brightness));
  }
}

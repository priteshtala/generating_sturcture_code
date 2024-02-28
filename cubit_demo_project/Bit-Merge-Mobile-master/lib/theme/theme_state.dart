import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final Brightness brightness;

  @override
  List<Object?> get props => [themeMode, brightness];

  const ThemeState({
    required this.themeMode,
    this.brightness = Brightness.dark,
  });

  bool get isDarkTheme => themeMode == ThemeMode.dark || brightness == Brightness.dark;

  ThemeState copyWith({
    ThemeMode? themeMode,
    Brightness? brightness,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      brightness: brightness ?? this.brightness,
    );
  }
}

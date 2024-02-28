import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final ThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];

  const ThemeChanged({required this.themeMode});
}

class ThemeUpdated extends ThemeEvent {
  final Brightness brightness;

  @override
  List<Object?> get props => [brightness];

  ThemeUpdated({required this.brightness});
}

import 'package:flutter/material.dart';

interface class Spacing {
  static const double none = 0;
  static const double xSmall = 4;
  static const double small = 8;
  static const double medium = 12;
  static const double normal = 16;
  static const double large = 20;
  static const double xLarge = 24;
}

interface class PaddingValue {
  static const EdgeInsets zero = EdgeInsets.zero;
  static const EdgeInsets xSmall = EdgeInsets.all(Spacing.xSmall);
  static const EdgeInsets small = EdgeInsets.all(Spacing.small);
  static const EdgeInsets medium = EdgeInsets.all(Spacing.medium);
  static const EdgeInsets normal = EdgeInsets.all(Spacing.normal);
  static const EdgeInsets large = EdgeInsets.all(Spacing.large);
  static const EdgeInsets xLarge = EdgeInsets.all(Spacing.xLarge);
  static const EdgeInsets scrollPadding = EdgeInsets.all(Spacing.large);
  static const EdgeInsets buttonPadding = EdgeInsets.all(Spacing.normal);
  static const EdgeInsets textButtonPadding = EdgeInsets.symmetric(horizontal: Spacing.medium, vertical: Spacing.xSmall);
}

interface class RadiusValue {
  static const double xSmall = 4;
  static const double small = 8;
  static const double medium = 12;
  static const double normal = 16;
  static const double large = 20;
  static const double xLarge = 24;
}

interface class ShapeRadius {
  static const Radius zero = Radius.zero;
  static const Radius xSmall = Radius.circular(RadiusValue.xSmall);
  static const Radius small = Radius.circular(RadiusValue.small);
  static const Radius medium = Radius.circular(RadiusValue.medium);
  static const Radius normal = Radius.circular(RadiusValue.normal);
  static const Radius large = Radius.circular(RadiusValue.large);
  static const Radius xLarge = Radius.circular(RadiusValue.xLarge);
}

interface class ShapeBorderRadius {
  static const BorderRadius zero = BorderRadius.zero;
  static const BorderRadius xSmall = BorderRadius.all(ShapeRadius.xSmall);
  static const BorderRadius small = BorderRadius.all(ShapeRadius.small);
  static const BorderRadius medium = BorderRadius.all(ShapeRadius.medium);
  static const BorderRadius normal = BorderRadius.all(ShapeRadius.normal);
  static const BorderRadius large = BorderRadius.all(ShapeRadius.large);
  static const BorderRadius xLarge = BorderRadius.all(ShapeRadius.xLarge);
}

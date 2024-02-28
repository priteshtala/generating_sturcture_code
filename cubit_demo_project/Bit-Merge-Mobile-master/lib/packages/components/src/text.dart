import 'dart:ui';

import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool isItalic;
  final double? height;
  final double? letterSpacing;
  final FontWeight fontWeight;
  final TextDecoration? decoration;
  final String? fontFamily;
  final Color? decorationColor;
  final TextStyle? style;

  const CommonText(
    this.text, {
    this.size = 14,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.fontWeight = FontWeight.normal,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.style,
  });

  const CommonText.extraBold(
    this.text, {
    this.size = 14,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.style,
  }) : fontWeight = FontWeight.w800;

  const CommonText.bold(
    this.text, {
    this.size = 14,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.style,
  }) : fontWeight = FontWeight.w700;

  const CommonText.semiBold(
    this.text, {
    this.size = 14,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.style,
  }) : fontWeight = FontWeight.w600;

  const CommonText.medium(
    this.text, {
    this.size = 14,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.style,
  }) : fontWeight = FontWeight.w500;

  const CommonText.regular(
    this.text, {
    this.size = 14,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height = 1.5,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.style,
  }) : fontWeight = FontWeight.w400;

  const CommonText.light(
    this.text, {
    this.size = 14,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height = 1.5,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.style,
  }) : fontWeight = FontWeight.w300;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final defaultTextStyle = DefaultTextStyle.of(context);

    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: defaultTextStyle.style.copyWith(
        fontFamily: fontFamily,
        color: color ?? colorScheme.onSurfaceVariant,
        fontSize: size,
        fontFeatures: [const FontFeature.tabularFigures()],
        fontStyle: isItalic ? FontStyle.italic : null,
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacing ?? 0,
        decoration: decoration,
        decorationColor: decorationColor ?? colorScheme.onSurface,
        inherit: true,
        textBaseline: TextBaseline.alphabetic,
      ),
    );
  }
}

import 'package:bit_merge_mobile/packages/resources/src/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

  abstract class AppTheme {
    static const defaultFontFamily = "PlusJakartaSans";

    static const AppColor _appColor = AppColor(
      failure: Color(0xFFF61D1D),
      success: Color(0xFF08C57D),
      pending: Color(0xFFED7A2C),
    );

    ///light color scheme
    static ThemeData get lightTheme {
      const colorScheme = ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF0DF69E),
          onPrimary: Color(0xFF141316),
          secondary: Color(0xFFD2D2D2),
          onSecondary: Color(0xFFFFFFFF),
          background: Color(0xFFF6F6F6),
          onBackground: Color(0xFF141316),
          surface: Color(0x40D2D2D2),
          onSurface: Color(0xFF737175),
          surfaceVariant: Color(0xFFFFFFFF),
          onSurfaceVariant: Color(0xFF141316),
          error: Color(0xFFF61D1D),
          onError: Color(0xFFFFFFFF),
          outline: Color(0xFFD2D2D2),
          outlineVariant: Color(0xFF141316),
          shadow: Color(0x669EA5BE),
          secondaryContainer: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFF737175),
          onPrimaryContainer: Color(0xFF141316),
          inverseSurface: Color(0xFF141316),
          tertiary: Color(0xFFD2D2D2),
          tertiaryContainer: Color(0x40D2D2D2),
          surfaceTint: Color(0xFF141316),
      );
      return themeData(colorScheme);
    }

    ///dark color scheme
    static ThemeData get darkTheme {
      const colorScheme = ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF0DF69E),
          onPrimary: Color(0xFF141316),
          secondary: Color(0xFFD2D2D2),
          onSecondary: Color(0xFFFFFFFF),
          background: Color(0xFF141316),
          onBackground: Color(0xFFFFFFFF),
          surface: Color(0xFF36323A),
          onSurface: Color(0xFF737175),
          surfaceVariant: Color(0xFF262329),
          onSurfaceVariant: Color(0xFFD2D2D2),
          error: Color(0xFFF61D1D),
          onError: Color(0xFFF5F7F9),
          outline: Color(0xFF36323A),
          outlineVariant: Color(0xFFFFFFFF),
          shadow: Color(0x669EA5BE),
          secondaryContainer: Color(0xFF36323A),
          primaryContainer: Color(0xFFD2D2D2),
          onPrimaryContainer: Color(0xFFFFFFFF),
          inverseSurface: Color(0xFF262329),
          tertiary: Color(0xFF181818),
          tertiaryContainer: Color(0xFF262329),
          surfaceTint: Color(0xFF0DF69E),
      );
      return themeData(colorScheme);
    }

    ///common theme data
    static ThemeData themeData(ColorScheme colorScheme) {
      return ThemeData(
        colorScheme: colorScheme,
        brightness: colorScheme.brightness,
        useMaterial3: true,
        extensions: const [_appColor],
        primaryColor: colorScheme.primary,
        primaryColorDark: colorScheme.primary,
        primaryColorLight: colorScheme.primary,
        indicatorColor: colorScheme.primary,
        disabledColor: colorScheme.primary.withOpacity(0.4),
        shadowColor: colorScheme.shadow,
        scaffoldBackgroundColor: colorScheme.background,
        fontFamily: defaultFontFamily,
        textTheme: textTheme(colorScheme),
        dialogTheme: dialogTheme(colorScheme),
        cardTheme: cardTheme(colorScheme),
        appBarTheme: appBarTheme(colorScheme),
        elevatedButtonTheme: elevatedButtonTheme(colorScheme),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              TextStyle(fontSize: 16, color: colorScheme.primary, fontFamily: defaultFontFamily),
            ),
          ),
        ),
        outlinedButtonTheme: outlinedButtonTheme(colorScheme),
        textSelectionTheme: textSelectionTheme(colorScheme),
        inputDecorationTheme: inputDecorationTheme(colorScheme),
        checkboxTheme: checkBoxTheme(colorScheme),
        radioTheme: radioTheme(colorScheme),
        tabBarTheme: tabBarTheme(colorScheme),
        dividerTheme: DividerThemeData(color: colorScheme.outline, thickness: 1, space: 1),
      );
    }

    static TextTheme textTheme(ColorScheme colorScheme) {
      return const TextTheme(
        headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      );
    }

    static AppBarTheme appBarTheme(ColorScheme colorScheme) {
      return AppBarTheme(
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.onBackground,
        centerTitle: true,
        titleSpacing: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: colorScheme.brightness,
          statusBarIconBrightness: ThemeData.estimateBrightnessForColor(colorScheme.onBackground),
          systemNavigationBarColor: colorScheme.background,
          statusBarColor: Colors.transparent,
        ),
        surfaceTintColor: colorScheme.background,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorScheme.onBackground,
          fontFamily: defaultFontFamily,
        ),
        toolbarHeight: kToolbarHeight,
      );
    }

    static BottomAppBarTheme bottomAppBarTheme(ColorScheme colorScheme) {
      return BottomAppBarTheme(
        color: colorScheme.background,
        elevation: 0,
        surfaceTintColor: colorScheme.background,
        padding: EdgeInsets.zero,
      );
    }

    static CardTheme cardTheme(ColorScheme colorScheme) {
      return CardTheme(
        shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.xLarge),
        margin: EdgeInsets.zero,
        color: colorScheme.surfaceVariant,
        surfaceTintColor: colorScheme.surfaceVariant,
        clipBehavior: Clip.hardEdge,
        shadowColor: colorScheme.shadow,
      );
    }

    static DialogTheme dialogTheme(ColorScheme colorScheme) {
      return DialogTheme(
        shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.xLarge),
        backgroundColor: colorScheme.background,
        surfaceTintColor: colorScheme.background,
        elevation: 0,
        titleTextStyle: TextStyle(
            fontSize: 16, color: colorScheme.onBackground, fontWeight: FontWeight.w500, fontFamily: defaultFontFamily),
        contentTextStyle: TextStyle(
            fontSize: 14, color: colorScheme.onBackground, fontWeight: FontWeight.w400, fontFamily: defaultFontFamily),
      );
    }

    static TextSelectionThemeData textSelectionTheme(ColorScheme colorScheme) {
      return TextSelectionThemeData(
        cursorColor: colorScheme.primary,
        selectionColor: colorScheme.primary.withOpacity(0.3),
        selectionHandleColor: colorScheme.primary,
      );
    }

    static ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) {
      return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          surfaceTintColor: colorScheme.onPrimary,
          elevation: 0,
          shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.small),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: defaultFontFamily,
            color: colorScheme.onPrimary,
          ),
        ),
      );
    }

    static OutlinedButtonThemeData outlinedButtonTheme(ColorScheme colorScheme) {
      return OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.background.withOpacity(0),
          foregroundColor: colorScheme.outlineVariant,
          shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.small),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: defaultFontFamily,
            color: colorScheme.outlineVariant,
          ),
        ),
      );
    }

    static InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) {
      final enableBorder = BorderSide(color: colorScheme.primary);
      final errorBorder = BorderSide(color: colorScheme.error);

      return InputDecorationTheme(
        floatingLabelStyle: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.primary),
        hintStyle: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.onSurface, fontSize: 14),
        errorStyle: const TextStyle(fontWeight: FontWeight.w500),
        errorMaxLines: 5,
        // constraints: const BoxConstraints(maxWidth: 440),
        filled: true,
        fillColor: colorScheme.surface,
        border: const OutlineInputBorder(borderRadius: ShapeBorderRadius.xSmall, borderSide: BorderSide.none),
        disabledBorder: const OutlineInputBorder(borderRadius: ShapeBorderRadius.xSmall, borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderRadius: ShapeBorderRadius.xSmall, borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: ShapeBorderRadius.xSmall, borderSide: enableBorder),
        focusedErrorBorder: OutlineInputBorder(borderRadius: ShapeBorderRadius.xSmall, borderSide: errorBorder),
        errorBorder: OutlineInputBorder(borderRadius: ShapeBorderRadius.xSmall, borderSide: errorBorder),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      );
    }

    static CheckboxThemeData checkBoxTheme(ColorScheme colorScheme) {
      return CheckboxThemeData(
        checkColor: MaterialStatePropertyAll(colorScheme.onPrimary),
        side: BorderSide(color: colorScheme.shadow),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100), side: const BorderSide(width: 1)),
      );
    }

    static RadioThemeData radioTheme(ColorScheme colorScheme) {
      return RadioThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.onSurface;
        }),
      );
    }

    static TabBarTheme tabBarTheme(ColorScheme colorScheme) {
      TextStyle labelStyle = TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: defaultFontFamily,
        color: colorScheme.onPrimary,
      );
      return TabBarTheme(
        labelStyle: labelStyle,
        unselectedLabelStyle: labelStyle.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
          fontFamily: defaultFontFamily,
        ),
        labelColor: colorScheme.onPrimary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
      );
    }

    static DividerThemeData dividerTheme(ColorScheme colorScheme) {
      return DividerThemeData(color: colorScheme.outline, thickness: 1, space: 1);
    }

    static PopupMenuThemeData popupMenuTheme(ColorScheme colorScheme) {
      return PopupMenuThemeData(
        color: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.xLarge),
        elevation: 0,
        textStyle: TextStyle(
            color: colorScheme.onPrimary, fontSize: 14, fontFamily: defaultFontFamily, fontWeight: FontWeight.w600),
      );
    }
  }

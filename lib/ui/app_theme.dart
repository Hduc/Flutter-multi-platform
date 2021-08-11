import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const Color shrinePink50 = Color(0xFFFEEAE6);
  static const Color shrinePink100 = Color(0xFFFEDBD0);
  static const Color shrinePink300 = Color(0xFFFBB8AC);
  static const Color shrinePink400 = Color(0xFFEAA4A4);

  static const Color shrineBrown900 = Color(0xFF442B2D);
  static const Color shrineBrown600 = Color(0xFF7D4F52);

  static const Color shrineErrorRed = Color(0xFFC5032B);

  static const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
  static const Color shrineBackgroundWhite = Colors.black;

  static const defaultLetterSpacing = 0.03;

  static const ColorScheme shrineColorScheme = ColorScheme(
    primary: shrinePink100,
    primaryVariant: shrineBrown900,
    secondary: shrinePink50,
    secondaryVariant: shrineBrown900,
    surface: shrineSurfaceWhite,
    background: shrineBackgroundWhite,
    error: shrineErrorRed,
    onPrimary: shrineBrown900,
    onSecondary: shrineBrown900,
    onSurface: shrineBrown900,
    onBackground: shrineBrown900,
    onError: shrineSurfaceWhite,
    brightness: Brightness.light,
  );

  static ThemeData buildShrineTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: shrineColorScheme,
      textTheme: buildShrineTextTheme(base.textTheme),
    );
  }

  static TextTheme buildShrineTextTheme(TextTheme base) {
    return base
        .copyWith(
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: defaultLetterSpacing,
          ),
          button: base.button.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            letterSpacing: defaultLetterSpacing,
          ),
        )
        .apply(
          fontFamily: 'Rubik',
          displayColor: shrineBrown900,
          bodyColor: shrineBrown900,
        );
  }
}

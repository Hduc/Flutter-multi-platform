import 'package:flutter/material.dart';
import 'package:severingthing/res/colors.dart';

class AppTheme {
  AppTheme._();

  static const defaultLetterSpacing = 0.03;

  static const ColorScheme shrineColorScheme = ColorScheme(
    primary: ColorTheme.shrinePink100,
    primaryVariant: ColorTheme.shrineBrown900,
    secondary: ColorTheme.shrinePink50,
    secondaryVariant: ColorTheme.shrineBrown900,
    surface: ColorTheme.shrineSurfaceWhite,
    background: ColorTheme.shrineBackgroundWhite,
    error: ColorTheme.shrineErrorRed,
    onPrimary: ColorTheme.shrineBrown900,
    onSecondary: ColorTheme.shrineBrown900,
    onSurface: ColorTheme.shrineBrown900,
    onBackground: ColorTheme.shrineBrown900,
    onError: ColorTheme.shrineSurfaceWhite,
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
          displayColor: ColorTheme.shrineBrown900,
          bodyColor: ColorTheme.shrineBrown900,
        );
  }
}

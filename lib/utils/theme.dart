import 'package:flutter/material.dart';

// app theme
final baseTheme = ThemeData.light();

// theme
final ThemeData appTheme = baseTheme.copyWith(
  primaryColor: appColors.darkGreen,
  appBarTheme: AppBarTheme(
    backgroundColor: appColors.white,
    elevation: 0,
  ),
  colorScheme: baseTheme.colorScheme.copyWith(
    secondary: appColors.green,
  ),
  scaffoldBackgroundColor: appColors.white,
  brightness: Brightness.light,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    linearTrackColor: appColors.lighterGreen,
    circularTrackColor: appColors.darkGreen.withOpacity(.1),
    color: appColors.darkGreen,
  ),
  buttonTheme: baseTheme.copyWith().buttonTheme.copyWith(
        buttonColor: appColors.darkGreen,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
  inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
    focusColor: appColors.darkGreen,
    fillColor: appColors.white,
  ),
  floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
    backgroundColor: appColors.green,
    foregroundColor: appColors.white,
  ),
  primaryIconTheme: baseTheme.primaryIconTheme.copyWith(
    color: appColors.darkGreen,
  ),
  iconTheme: baseTheme.iconTheme.copyWith(
    color: appColors.darkGreen,
  ),
  sliderTheme: baseTheme.sliderTheme.copyWith(
    overlayShape: SliderComponentShape.noOverlay,
  ),
);

// app colors
const appColors = ThemeModel(
  lighterGreen: Color(0xFFC1F297),
  lightGreen: Color(0xFFA5CF61),
  lightestGreen: Color(0xFFF7FBF1),
  green: Color(0xFF01A985),
  splashGreen: Color(0xffBCEF95),
  darkGreen: Color(0xFF008067),
  white: Color(0xFFFFFFFF),
  error: Color(0xFFFF0000),
  warning: Color(0xFF808080),
  black: Color(0xFF000000),
);

// theme model
class ThemeModel {
  const ThemeModel({
    required this.lighterGreen,
    required this.lightGreen,
    required this.lightestGreen,
    required this.green,
    required this.darkGreen,
    required this.splashGreen,
    required this.white,
    required this.error,
    required this.warning,
    required this.black,
  });

  final Color lighterGreen;
  final Color lightGreen;
  final Color lightestGreen;
  final Color green;
  final Color darkGreen;
  final Color splashGreen;
  final Color white;
  final Color error;
  final Color warning;
  final Color black;
}

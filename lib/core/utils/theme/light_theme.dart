import 'package:flutter/material.dart';

import 'color/light_theme_color.dart';

class LightTheme {
  static ThemeData getTheme() {
    final colors = LightThemeColor();
    return ThemeData(
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.scaffoldColor,
      hintColor: colors.hintColor,
      colorScheme: ColorScheme.fromSeed(seedColor: colors.primary),
    );
  }
}

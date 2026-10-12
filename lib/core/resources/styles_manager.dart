import 'package:flutter/material.dart';

import '../utils/theme/color/light_theme_color.dart';

class ShadowStyles {
  /// Toasts.
  static List<BoxShadow> get toast => [
    BoxShadow(
      color: LightThemeColor().toastShadow,
      offset: const Offset(0, 12),
      blurRadius: 30,
    ),
  ];
}

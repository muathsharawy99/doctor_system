import 'package:flutter/material.dart';

import 'base_color.dart';

/// D❤CARE palette (Material blue, red heart, orange "CARE").
class LightThemeColor extends BaseColor {
  // ── Brand
  @override
  Color get primary => const Color(0xFF2196F3);
  @override
  Color get onPrimary => const Color(0xFFFFFFFF);
  @override
  Color get accent => const Color(0xFFFF9800);

  // ── Surfaces
  @override
  Color get scaffoldColor => const Color(0xFFFFFFFF);
  @override
  Color get surface => const Color(0xFFFFFFFF);

  // ── Text
  @override
  Color get defaultTextColor => const Color(0xFF000000);
  @override
  Color get hintColor => const Color(0xFF9E9E9E);

  // ── Status
  @override
  Color get errorColor => const Color(0xFFF44336);
  @override
  Color get successColor => const Color(0xFF4CAF50);

  // ── Toast
  @override
  Color get toastColor => const Color(0xFF212121);
  @override
  Color get toastSuccessDot => const Color(0xFF4CAF50);
  @override
  Color get toastErrorDot => const Color(0xFFF44336);
  @override
  Color get toastShadow => const Color(0x4D212121);
}

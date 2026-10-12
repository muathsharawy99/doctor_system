import 'dart:developer';

import 'package:doctor/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension StringContext on String {
  /// `#2196F3` / `2196F3` → [Color] (used by `Model.colorFromJson`).
  Color get color {
    try {
      String colorStr = replaceAll("#", "");
      if (colorStr.length == 6) {
        colorStr = "FF$colorStr";
      }
      return Color(int.parse(colorStr, radix: 16));
    } catch (e) {
      log('Error parsing color: $e');
      return Colors.transparent;
    }
  }
}

class Validator {
  Validator._();

  /// Required field; [messageKey] is a `LocaleKeys` key.
  static String? Function(String?) notEmpty(String messageKey) =>
      (value) => (value == null || value.isEmpty) ? messageKey.tr() : null;

  static String? password(String? value) => (value ?? '').trim().length < 8
      ? LocaleKeys.validations_password_min.tr()
      : null;

  static String? address(String? value) => (value ?? '').length < 6
      ? LocaleKeys.validations_address_min.tr()
      : null;
}

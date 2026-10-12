import 'package:flutter/material.dart';

class AppConstants {
  /// The design frame the screens were drawn on.
  static const Size appSize = Size(375, 812);
  static const splashDuration = Duration(milliseconds: 2500);

  /// The API answers with `code` 200 / 201 in the body on success.
  static const successCodes = [200, 201];

  /// Date pickers.
  static final firstBirthDate = DateTime(1924);
  static final firstVisitDate = DateTime(2020);
  static final lastVisitDate = DateTime(2030);
}

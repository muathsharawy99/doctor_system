import 'package:flutter/material.dart';

abstract class BaseColor {
  // Brand
  Color get primary;
  Color get onPrimary;
  Color get accent;

  // Surfaces
  Color get scaffoldColor;
  Color get surface;

  // Text
  Color get defaultTextColor;
  Color get hintColor;

  // Status
  Color get errorColor;
  Color get successColor;

  // Toast
  Color get toastColor;
  Color get toastSuccessDot;
  Color get toastErrorDot;
  Color get toastShadow;
}

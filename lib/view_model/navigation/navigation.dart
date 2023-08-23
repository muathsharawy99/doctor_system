import 'package:flutter/material.dart';

class Navigation {
  static void goPop(context) {
    Navigator.pop(context);
  }

  static void goPush(context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static void goPushAndReplacement(context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static void pushAndRemoveUntil(context, Widget secondScreen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => secondScreen,
      ),
      (route) => false,
    );
  }
}

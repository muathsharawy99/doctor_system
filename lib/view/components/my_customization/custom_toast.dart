import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required msg,
  required bool isError,
  Color? textColor,
  double? fontSize,
}) =>
    Fluttertoast.showToast(
      msg: msg.toString(),
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: textColor,
      gravity: ToastGravity.BOTTOM,
      fontSize: fontSize,
    );

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final double? radius;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool? readOnly;
  final bool? obscureText;
  final bool? filled;
  final Color? fillColor;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final String? Function(String? v)? validator;
  final TextInputAction? whatToDoNext;
  final BorderSide? borderSide;

  const CustomTextField({
    Key? key,
    this.radius,
    this.readOnly,
    this.obscureText,
    this.filled,
    this.fillColor,
    this.label,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.validator,
    this.whatToDoNext,
    this.borderSide,
    required this.controller,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(
        radius ?? 0.r,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly ?? false,
        obscureText: obscureText ?? false,
        validator: validator,
        textInputAction: whatToDoNext,
        onFieldSubmitted: (v) => FocusScope.of(context).nextFocus(),
        decoration: InputDecoration(
          filled: filled,
          fillColor: fillColor,
          label: Text(label ?? ""),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: borderSide ?? const BorderSide(),
            borderRadius: BorderRadius.circular(
              radius ?? 0.r,
            ),
          ),
        ),
      ),
    );
  }
}

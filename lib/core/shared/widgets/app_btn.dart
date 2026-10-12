import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/unified_extensions.dart';

/// Rounded elevated button; full width × 60 by default.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.width,
    this.height,
    this.radius,
    this.isLoading = false,
  });

  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final double? width, height, radius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final textColor = color == null ? context.primaryColor : context.onPrimary;
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? AppSize.s60.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              radius ?? AppSize.radiusField.r,
            ),
          ),
        ),
        child: isLoading
            ? CustomProgress(size: AppSize.s24.w, color: textColor)
            : Text(
                title,
                style: context.medium.copyWith(
                  fontSize: FontSize.s18,
                  color: textColor,
                ),
              ),
      ),
    );
  }
}

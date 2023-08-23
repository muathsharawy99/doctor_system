import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? bGColor;
  final double? elevation;
  final double? radius;
  final double? width;
  final double? height;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.bGColor,
    this.elevation,
    this.radius,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius ?? 0.r,
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bGColor,
          elevation: elevation,
        ),
        child: child,
      ),
    );
  }
}

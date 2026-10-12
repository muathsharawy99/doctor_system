import 'package:doctor/core/extensions/unified_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Doctor / Admin choice on login (blue when selected).
class RoleTile extends StatelessWidget {
  const RoleTile({
    super.key,
    required this.label,
    required this.imagePath,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String imagePath;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? context.primaryColor : context.hintColor;
    final radius = BorderRadius.circular(AppSize.s25.r);
    return InkWell(
      onTap: onTap,
      borderRadius: radius,
      child: Container(
        width: AppSize.s150.w,
        height: AppSize.s150.w,
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(width: AppSize.borderWidth.w, color: color),
          color: context.surfaceColor,
        ),
        child: Column(
          children: [
            CustomImage(imagePath).expand(),
            SizedBox(height: AppSize.s10.h),
            Text(
              label,
              style: context.bold.copyWith(fontSize: FontSize.s20, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

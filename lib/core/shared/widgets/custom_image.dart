import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/unified_extensions.dart';

/// Asset image (`Assets.images.x.path`) with a broken-image fallback.
class CustomImage extends StatelessWidget {
  const CustomImage(
    this.path, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
  });

  final String path;
  final double? height, width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      height: height,
      width: width,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.broken_image_outlined,
        color: context.hintColor,
        size: AppSize.s24.w,
      ),
    );
  }
}

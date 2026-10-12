import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/locale_keys.g.dart';
import '../../extensions/unified_extensions.dart';

/// Full-page error (wifi-off for network errors) with a refresh button.
class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.title,
    this.errorStatus,
    this.onTap,
  });

  final String title;
  final ErrorType? errorStatus;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isNetwork = errorStatus?.isNetwork == true;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isNetwork ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
          size: AppSize.s64.w,
          color: context.errorColor,
        ),
        SizedBox(height: AppSize.s16.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.bold.copyWith(fontSize: FontSize.s15),
        ),
        if (onTap != null) ...[
          SizedBox(height: AppSize.s20.h),
          AppButton(
            title: LocaleKeys.static_refresh.tr(),
            onPressed: onTap!,
            width: AppSize.s150.w,
            height: AppSize.s50.h,
          ),
        ],
      ],
    ).withPadding(horizontal: AppSize.s24.w).center;
  }
}

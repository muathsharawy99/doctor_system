import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/unified_extensions.dart';

/// Blue app bar with a bold centered title and an optional back button.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
    this.actions,
  });

  final String title;
  final bool showBack;

  /// Runs before popping.
  final VoidCallback? onBack;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(AppSize.s70.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.primaryColor,
      foregroundColor: context.onPrimary,
      toolbarHeight: AppSize.s70.h,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              onPressed: () {
                onBack?.call();
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
            )
          : null,
      title: Text(
        title,
        style: context.bold.copyWith(
          fontSize: FontSize.s20,
          color: context.onPrimary,
        ),
      ),
      actions: actions,
    );
  }
}

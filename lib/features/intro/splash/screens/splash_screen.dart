import 'package:doctor/core/extensions/unified_extensions.dart';
import 'package:doctor/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

/// Logo animation + "D❤CARE", then the create-account screen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    await Future<void>.delayed(AppConstants.splashDuration);
    if (!mounted) return;
    replacement(NamedRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    final style = context.bold.copyWith(fontSize: FontSize.s50);
    return Scaffold(
      backgroundColor: context.surfaceColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Assets.lottieFiles.logo.path,
            width: AppSize.s400.w,
            repeat: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('D', style: style.copyWith(color: context.errorColor)),
              Icon(
                Icons.favorite,
                color: context.errorColor,
                size: AppSize.s50.w,
              ),
              Text('CARE', style: style.copyWith(color: context.accentColor)),
            ],
          ),
        ],
      ).center,
    );
  }
}

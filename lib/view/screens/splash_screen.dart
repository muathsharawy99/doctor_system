import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 400.w,
          child: LottieBuilder.asset(
            "assets/lottie_files/logo.json",
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "D",
              style: TextStyle(
                fontSize: 50.sp,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: 50.w,
            ),
            Text(
              "CARE",
              style: TextStyle(
                fontSize: 50.sp,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    );
  }
}

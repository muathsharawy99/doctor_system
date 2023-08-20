import 'package:doctor/view/screens/auth/register_screen.dart';
import 'package:doctor/view/screens/doctor/patient/all_patient_screen.dart';
import 'package:doctor/view_model/bloc/login_bloc/login_cubit.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_cubit.dart';
import 'package:doctor/view_model/bloc/register_bloc/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor/view/screens/splash_screen.dart';
import 'package:doctor/view_model/bloc/bloc_observer/bloc_observer.dart';
import 'package:doctor/view_model/local/shared_preferences/shared_preferences.dart';
import 'package:doctor/view_model/network/dio_helper/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreference.initShared();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RegisterCubit(),
            ),BlocProvider(
              create: (context) => LoginCubit(),
            ),BlocProvider(
              create: (context) => PatientCubit()..getAllPatient(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AllPatient(),

            // AnimatedSplashScreen(
            //   // duration: 60000,
            //   backgroundColor: Colors.blue,
            //   nextScreen: RegisterScreen(),
            //   splashTransition: SplashTransition.fadeTransition,
            //   splash: SplashScreen(),
            //   splashIconSize: MediaQuery.of(context).size.width,
            // ),
          ),
        );
      },
    );
  }
}

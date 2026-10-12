import 'package:flutter/material.dart';

import '../../../features/auth/screens/login/screens/login_screen.dart';
import '../../../features/auth/screens/register/screens/register_screen.dart';
import '../../../features/intro/splash/screens/splash_screen.dart';
import '../../../features/patients/data/models/patient_model.dart';
import '../../../features/patients/screens/add/screens/add_patient_screen.dart';
import '../../../features/patients/screens/details/screens/patient_details_screen.dart';
import '../../../features/patients/screens/list/screens/patients_screen.dart';
import '../../../features/profile/screens/profile_screen.dart';
import '../../extensions/context_extensions.dart';
import 'routes.dart';

class AppRoutes {
  static AppRoutes get init => AppRoutes._internal();

  String initial = NamedRoutes.splash;

  AppRoutes._internal();

  Map<String, Widget Function(BuildContext c)> appRoutes = {
    NamedRoutes.splash: (c) => const SplashScreen(),
    NamedRoutes.register: (c) => const RegisterScreen(),
    NamedRoutes.login: (c) => const LoginScreen(),
    NamedRoutes.patients: (c) => const PatientsScreen(),
    NamedRoutes.addPatient: (c) => const AddPatientScreen(),
    NamedRoutes.patientDetails: (c) => PatientDetailsScreen(
      patient: c.arg[RouteString.patient] as PatientModel? ??
          PatientModel.fromJson(),
    ),
    NamedRoutes.profile: (c) => const ProfileScreen(),
  };
}

class RouteString {
  static const patient = "patient";
}

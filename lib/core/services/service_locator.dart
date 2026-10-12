import 'package:get_it/get_it.dart';

import '../../features/auth/screens/login/manager/login_cubit.dart';
import '../../features/auth/screens/login/service/login_service.dart';
import '../../features/auth/screens/register/manager/register_cubit.dart';
import '../../features/auth/screens/register/service/register_service.dart';
import '../../features/patients/screens/add/manager/add_patient_cubit.dart';
import '../../features/patients/screens/details/manager/patient_details_cubit.dart';
import '../../features/patients/screens/list/manager/patients_cubit.dart';
import '../../features/patients/service/patients_service.dart';
import '../../features/profile/manager/profile_cubit.dart';
import '../../features/profile/service/profile_service.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    //auth
    sl.registerFactory(() => RegisterCubit(RegisterService()));
    sl.registerFactory(() => LoginCubit(LoginService()));

    //patients
    sl.registerFactory(() => PatientsCubit(PatientsService()));
    sl.registerFactory(() => AddPatientCubit(PatientsService()));
    sl.registerFactory(() => PatientDetailsCubit(PatientsService()));

    //profile
    sl.registerFactory(() => ProfileCubit(ProfileService()));
  }
}

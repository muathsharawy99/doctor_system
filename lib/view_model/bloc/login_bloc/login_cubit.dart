import 'package:doctor/model/doctor_model.dart';
import 'package:doctor/view/components/my_customization/custom_toast.dart';
import 'package:doctor/view/screens/doctor/patient/all_patient_screen.dart';
import 'package:doctor/view_model/bloc/login_bloc/login_state.dart';
import 'package:doctor/view_model/local/shared_preferences/shared_key.dart';
import 'package:doctor/view_model/local/shared_preferences/shared_preferences.dart';
import 'package:doctor/view_model/navigation/navigation.dart';
import 'package:doctor/view_model/network/dio_helper/dio_helper.dart';
import 'package:doctor/view_model/network/dio_helper/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitState());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  var formKey = GlobalKey<FormState>();

  bool isVisible = true;
  bool isDoctor = true;
  bool isAdmin = false;

  DoctorModel? doctorModel;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void showPassword() {
    isVisible = !isVisible;
    emit(ShowPasswordState());
  }

  void changeDoctor() {
    isDoctor = !isDoctor;
    isAdmin = false;
    emit(ChangeDoctorState());
  }

  void changeAdmin() {
    isAdmin = !isAdmin;
    isDoctor = false;
    emit(ChangeAdminState());
  }

  void login(context) async {
    emit(LoginLoadingState());
    await DioHelper.post(endPoint: EndPoints.login, data: {
      "email": emailController.text,
      "password": passwordController.text,
    }).then((value) {
      if (value.data["code"] == 200) {
        doctorModel = DoctorModel.fromJson(value.data);
        SharedPreference.set(SharedKeys.userToken, value.data['token']);
        SharedPreference.set(SharedKeys.userName, doctorModel?.data?.name);
        SharedPreference.set(SharedKeys.userPassword, passwordController.text);
        SharedPreference.set(SharedKeys.userType, doctorModel?.data?.type);
        SharedPreference.set(SharedKeys.userTitle, doctorModel?.data?.title);
        SharedPreference.set(
            SharedKeys.userAddress, doctorModel?.data?.address);
        showToast(msg: value.data['message'], isError: false);
        Navigation.pushAndRemoveUntil(
          context,
          const AllPatientScreen(),
        );
        clearController();
        emit(LoginSuccessState());
      } else {
        showToast(msg: value.data['message'], isError: true);
        emit(LoginErrorState());
      }
    });
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
  }
}

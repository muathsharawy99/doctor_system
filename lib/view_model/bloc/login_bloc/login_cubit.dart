import 'package:doctor/view/components/my_customization/custom_toast.dart';
import 'package:doctor/view_model/bloc/login_bloc/login_state.dart';
import 'package:doctor/view_model/local/shared_preferences/shared_key.dart';
import 'package:doctor/view_model/local/shared_preferences/shared_preferences.dart';
import 'package:doctor/view_model/network/dio_helper/dio_helper.dart';
import 'package:doctor/view_model/network/dio_helper/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitState());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  var formKey = GlobalKey<FormState>();

  bool isVisible = true;


  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void showPassword() {
    isVisible = !isVisible;
    emit(ShowPasswordState());
  }

  void login() async {
    emit(LoginLoadingState());
    await DioHelper.post(endPoint: EndPoints.login, data: {
      "email": emailController.text,
      "password": passwordController.text,
    }).then((value) {
      if (value.data["code"] == 200) {
        SharedPreference.set(SharedKeys.token, value.data['token']);
        showToast(msg: value.data['message'], isError: false);
        emit(LoginSuccessState());
      } else {
        showToast(msg: value.data['message'], isError: true);
        emit(LoginErrorState());
      }
    });
  }
}

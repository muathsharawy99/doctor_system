import 'package:doctor/view/screens/auth/login_screen.dart';
import 'package:doctor/view_model/bloc/register_bloc/register_state.dart';
import 'package:doctor/view_model/navigation/navigation.dart';
import 'package:doctor/view_model/network/dio_helper/dio_helper.dart';
import 'package:doctor/view_model/network/dio_helper/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../view/components/my_customization/custom_toast.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitState());

  static RegisterCubit get(context) => BlocProvider.of<RegisterCubit>(context);

  var formKey = GlobalKey<FormState>();

  bool isVisible = true;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var addressController = TextEditingController();

  void showPassword() {
    isVisible = !isVisible;
    emit(ShowPasswordState());
  }

  void register(context) async {
    emit(RegisterLoadingState());
    await DioHelper.post(endPoint: EndPoints.register, data: {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "address": addressController.text,
    }).then((value) {
      if (value.data['code'] == 200 || value.data['code'] == 201) {
        showToast(msg: value.data['message'], isError: false);
        Navigation.pushAndRemoveUntil(
          context,
          const LoginScreen(),
        );
        clearController();
        emit(RegisterSuccessState());
      } else {
        showToast(msg: value.data['message'], isError: true);
        emit(RegisterErrorState());
      }
    });
  }

  void clearController() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    addressController.clear();
  }
}

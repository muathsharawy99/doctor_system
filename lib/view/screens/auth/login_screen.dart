import 'package:doctor/view/components/my_customization/custom_button.dart';
import 'package:doctor/view/components/my_customization/custom_textfield.dart';
import 'package:doctor/view_model/bloc/login_bloc/login_cubit.dart';
import 'package:doctor/view_model/bloc/login_bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: cubit.formKey,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              toolbarHeight: 70.h,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "Login To Your Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 10.w,
                  end: 10.w,
                  top: 30.w,
                  bottom: 30.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200.h,
                      child: LottieBuilder.asset(
                        "assets/lottie_files/register_hello.json",
                      ),
                    ),
                    CustomTextField(
                      radius: 10.r,
                      controller: cubit.emailController,
                      keyboardType: TextInputType.emailAddress,
                      label: "Email",
                      whatToDoNext: TextInputAction.next,
                      suffixIcon: IconButton(
                        onPressed: () {
                          cubit.emailController.clear();
                        },
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      controller: cubit.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      label: "Password",
                      whatToDoNext: TextInputAction.next,
                      validator: (v) {
                        if (v!.trim().length < 8) {
                          return "Your password must be at least 8 characters";
                        }
                        return null;
                      },
                      obscureText: cubit.isVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          cubit.showPassword();
                        },
                        icon: cubit.isVisible == true
                            ? Icon(
                                Icons.visibility_outlined,
                              )
                            : Icon(
                                Icons.visibility_off_outlined,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 240.h,
                    ),
                    CustomButton(
                      width: double.infinity,
                      height: 60.h,
                      radius: 10.r,
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.login();
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

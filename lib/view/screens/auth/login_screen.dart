import 'package:doctor/view/components/my_customization/custom_button.dart';
import 'package:doctor/view/components/my_customization/custom_textfield.dart';
import 'package:doctor/view/components/my_customization/custom_toast.dart';
import 'package:doctor/view_model/bloc/login_bloc/login_cubit.dart';
import 'package:doctor/view_model/bloc/login_bloc/login_state.dart';
import 'package:doctor/view_model/navigation/navigation.dart';
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
              leading: IconButton(
                onPressed: () {
                  Navigation.goPop(context);
                  cubit.clearController();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
              ),
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
                        "assets/lottie_files/hello.json",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            cubit.changeDoctor();
                          },
                          borderRadius: BorderRadius.circular(
                            25.r,
                          ),
                          child: Container(
                            width: 150.w,
                            height: 150.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                25.r,
                              ),
                              border: Border.all(
                                width: 2.w,
                                color:
                                    cubit.isDoctor ? Colors.blue : Colors.grey,
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    "assets/images/doctor.png",
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  child: Text(
                                    "Doctor",
                                    style: TextStyle(
                                      color: cubit.isDoctor
                                          ? Colors.blue
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            cubit.changeAdmin();
                          },
                          borderRadius: BorderRadius.circular(
                            25.r,
                          ),
                          child: Container(
                            width: 150.w,
                            height: 150.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                25.r,
                              ),
                              border: Border.all(
                                width: 2.w,
                                color:
                                    cubit.isAdmin ? Colors.blue : Colors.grey,
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    "assets/images/admin.png",
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  child: Text(
                                    "Admin",
                                    style: TextStyle(
                                      color: cubit.isAdmin
                                          ? Colors.blue
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Visibility(
                      replacement: SizedBox(
                        height: 200.h,
                        child: LottieBuilder.asset(
                          "assets/lottie_files/soon.json",
                        ),
                      ),
                      visible: !cubit.isAdmin,
                      child: Column(
                        children: [
                          CustomTextField(
                            radius: 10.r,
                            controller: cubit.emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: "Email",
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Your must type your email";
                              }

                              return null;
                            },
                            whatToDoNext: TextInputAction.next,
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.emailController.clear();
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          CustomTextField(
                            radius: 10.r,
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
                                  ? const Icon(
                                      Icons.visibility_outlined,
                                    )
                                  : const Icon(
                                      Icons.visibility_off_outlined,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 10.w,
                end: 10.w,
                bottom: 10.w,
              ),
              child: CustomButton(
                width: double.infinity,
                height: 60.h,
                radius: 10.r,
                onPressed: () {
                  if (cubit.formKey.currentState!.validate() &&
                      (cubit.isDoctor || cubit.isAdmin) == true) {
                    cubit.login(context);
                  } else if ((cubit.isDoctor || cubit.isAdmin) != true) {
                    showToast(
                      msg: "Please select your type",
                      isError: true,
                    );
                  }
                },
                child: state is LoginLoadingState
                    ? CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                        strokeWidth: 2,
                      )
                    : Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:doctor/view/components/my_customization/custom_button.dart';
import 'package:doctor/view/components/my_customization/custom_textfield.dart';
import 'package:doctor/view/screens/auth/login_screen.dart';
import 'package:doctor/view_model/bloc/register_bloc/register_cubit.dart';
import 'package:doctor/view_model/bloc/register_bloc/register_state.dart';
import 'package:doctor/view_model/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterState>(
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
                "Create Account",
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
                      height: 175.h,
                      child: LottieBuilder.asset(
                        "assets/lottie_files/hello.json",
                      ),
                    ),
                    CustomTextField(
                      radius: 10.r,
                      controller: cubit.nameController,
                      keyboardType: TextInputType.name,
                      label: "Name",
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Your must type your name";
                        }
                        return null;
                      },
                      whatToDoNext: TextInputAction.next,
                      suffixIcon: IconButton(
                        onPressed: () {
                          cubit.nameController.clear();
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
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
                      height: 15.h,
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
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(
                      radius: 10.r,
                      controller: cubit.addressController,
                      keyboardType: TextInputType.streetAddress,
                      label: "Address",
                      whatToDoNext: TextInputAction.next,
                      validator: (v) {
                        if (v!.length < 6) {
                          return "Your address must be at least 6 characters";
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          cubit.addressController.clear();
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomButton(
                      width: double.infinity,
                      height: 60.h,
                      radius: 10.r,
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.register(context);
                        }
                      },
                      child: state is RegisterLoadingState
                          ? CircularProgressIndicator.adaptive()
                          : Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const Text("Already have an account"),
                    TextButton(
                      onPressed: () {
                        cubit.clearController();
                        Navigation.goPush(
                          context,
                          const LoginScreen(),
                        );
                      },
                      child: Text(
                        "Login Now",
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "By continuing you agreeing to our ",
                          ),
                          TextSpan(
                            text:
                                "Customer Terms of Services, Privacy Policy, ",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "and ",
                          ),
                          TextSpan(
                            text: "Cookie Policy.",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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

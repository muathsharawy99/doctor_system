import 'package:doctor/view/components/my_customization/custom_button.dart';
import 'package:doctor/view/components/my_customization/custom_textfield.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_cubit.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_state.dart';
import 'package:doctor/view_model/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, PatientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PatientCubit.get(context);
        cubit.initDoctorController();
        return Scaffold(
          resizeToAvoidBottomInset: true,
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
              "Profile",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(radius: 10.r,label: "Name",
                      controller: cubit.nameController,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(radius: 10.r,label: "Password",
                      controller: cubit.passwordController,
                      keyboardType: TextInputType.datetime,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Type",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(radius: 10.r,label: "Type",
                      controller: cubit.typeController,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(radius: 10.r,label: "Title",
                      controller: cubit.titleController,
                      keyboardType: TextInputType.datetime,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomTextField(radius: 10.r,label: "Address",
                      controller: cubit.addressController,
                      keyboardType: TextInputType.streetAddress,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          width: 150.w,
                          height: 50.h,
                          radius: 30.r,
                          bGColor: Colors.green,
                          onPressed: () {},
                          child: const Text(
                            "Save",
                          ),
                        ),
                        CustomButton(
                          width: 150.w,
                          height: 50.h,
                          radius: 30.r,
                          bGColor: Colors.red,
                          onPressed: () {
                            cubit.logout(context);
                          },
                          child: const Text(
                            "Logout",
                          ),
                        ),
                      ],
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

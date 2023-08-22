import 'package:doctor/model/patient_model.dart';
import 'package:doctor/view/components/my_customization/custom_button.dart';
import 'package:doctor/view/components/my_customization/custom_textfield.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_cubit.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_state.dart';
import 'package:doctor/view_model/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientDetailsScreen extends StatelessWidget {


  const PatientDetailsScreen({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, PatientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PatientCubit.get(context);
        cubit.initController();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                cubit.getAllPatient();
                Navigation.goPop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
              ),
            ),
            centerTitle: true,
            title: Text(
              "Patient",
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                     "Hiiii",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                    controller: cubit.nameController,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Date of birth",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                    controller: cubit.dOBController,
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Diagnosis",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                    controller: cubit.diagnosisController,
                    keyboardType: TextInputType.text,
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
                  CustomTextField(
                    controller: cubit.addressController,
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    "Visit time",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                    controller: cubit.visitTimeController,
                    keyboardType: TextInputType.datetime,
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
                        child: Text(
                          "Save",
                        ),
                      ),
                      CustomButton(
                        width: 150.w,
                        height: 50.h,
                        radius: 30.r,
                        bGColor: Colors.red,
                        onPressed: () {},
                        child: Text(
                          "Delete",
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

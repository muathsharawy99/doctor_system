import 'package:doctor/model/patient_model.dart';
import 'package:doctor/view/components/components/patient_card.dart';
import 'package:doctor/view/components/my_customization/custom_button.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_cubit.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllPatient extends StatelessWidget {
  AllPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, PatientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PatientCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(
              10.w,
            ),
            child: ListView.separated(
              itemBuilder: (context, index) => PatientCard(
                currentIndex: index,
                dataP: cubit.patientModel?.data?.data?[index] ?? DataP(),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: cubit.patientModel?.data?.data?.length ?? 1,
            ),
          ),
          bottomNavigationBar: CustomButton(
            onPressed: () {},
            child: Text(
              "data",
            ),
          ),
        );
      },
    );
  }
}

import 'package:doctor/model/patient_model.dart';
import 'package:doctor/view/screens/doctor/patient/patient_details_screen.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_cubit.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_state.dart';
import 'package:doctor/view_model/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientCard extends StatelessWidget {
  final Details? dataP;
  int? currentIndex;

  PatientCard({required this.dataP, required this.currentIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, PatientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PatientCubit.get(context);
        return InkWell(
          onTap: () {
            cubit.changeCurrentIndex(currentIndex);
            Navigation.goPush(
              context,
              PatientDetailsScreen(),
            );
          },
          borderRadius: BorderRadius.circular(
            20.r,
          ),
          child: Container(
            padding: EdgeInsets.all(
              10.w,
            ),
            width: 50.w,
            height: 175.h,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(
                20.r,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Name : ${dataP?.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Diagnosis : ${dataP?.diagnosis}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Visit Time : ${dataP?.visitTime}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Address : ${dataP?.address}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

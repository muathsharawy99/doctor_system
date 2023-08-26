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
        return Material(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.blue,
          borderRadius: BorderRadius.circular(
            20.r,
          ),
          child: InkWell(
            onTap: () {
              cubit.changeCurrentIndex(currentIndex);
              Navigation.goPush(
                context,
                const PatientDetailsScreen(),
              );
            },
            borderRadius: BorderRadius.circular(
              20.r,
            ),
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 175.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20.r,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 120.h,
                    height: 175.h,
                    color: Colors.white,
                    child: Image.asset(
                      "assets/images/patient.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.all(
                        10.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            dataP?.name ?? "No Name",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            dataP?.diagnosis ?? "No Diagnosis",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            dataP?.visitTime ?? "No Visit Time",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            dataP?.address ?? "No Address",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

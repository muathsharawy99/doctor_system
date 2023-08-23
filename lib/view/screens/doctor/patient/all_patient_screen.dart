import 'package:doctor/model/patient_model.dart';
import 'package:doctor/view/components/components/patient_card.dart';
import 'package:doctor/view/components/my_customization/custom_button.dart';
import 'package:doctor/view/screens/doctor/doctor_profile_screen.dart';
import 'package:doctor/view/screens/doctor/patient/add_patient_screen.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_cubit.dart';
import 'package:doctor/view_model/bloc/patient_bloc/patient_state.dart';
import 'package:doctor/view_model/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AllPatientScreen extends StatelessWidget {
  const AllPatientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, PatientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PatientCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            toolbarHeight: 70.h,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Patient List",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  end: 10.w,
                ),
                child: InkWell(
                  onTap: () {
                    Navigation.goPush(
                      context,
                      const DoctorScreen(),
                    );
                  },
                  child: Container(
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: Image.asset(
                          "assets/images/doctor.png",
                        ).image,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: state is GetAllPatientLoadingState
              ? Center(
                  child: LottieBuilder.asset(
                    "assets/lottie_files/waiting.json",
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(
                    10.w,
                  ),
                  child: cubit.patientModel!.data!.data!.isEmpty
                      ? Center(
                          child: LottieBuilder.asset(
                            "assets/lottie_files/no_result_found.json",
                          ),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) => PatientCard(
                            currentIndex: index,
                            dataP: cubit.patientModel?.data?.data?[index] ??
                                Details(),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10.h,
                          ),
                          itemCount:
                              cubit.patientModel?.data?.data?.length ?? 1,
                        ),
                ),
          bottomNavigationBar: Padding(
            padding: EdgeInsetsDirectional.only(
              bottom: 10.w,
              start: 10.w,
              end: 10.w,
            ),
            child: CustomButton(
              radius: 20.r,
              height: 70.h,
              onPressed: () {
                Navigation.goPush(
                  context,
                  const AddPatientScreen(),
                );
              },
              child: const Text(
                "Add New Patient",
              ),
            ),
          ),
        );
      },
    );
  }
}

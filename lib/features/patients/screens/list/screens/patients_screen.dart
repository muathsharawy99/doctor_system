import 'package:doctor/core/extensions/unified_extensions.dart';
import 'package:doctor/core/services/service_locator.dart';
import 'package:doctor/gen/assets.gen.dart';
import 'package:doctor/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/patient_card.dart';
import '../manager/patients_cubit.dart';
import '../manager/patients_state.dart';

/// The doctor's patients; reloads after adding / editing / deleting.
class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final PatientsCubit cubit = sl<PatientsCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getPatients();
  }

  @override
  void dispose() {
    if (!cubit.isClosed) cubit.close();
    super.dispose();
  }

  Future<void> _open(String route, {dynamic arg}) async {
    await push(route, arg: arg);
    if (mounted) cubit.getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: LocaleKeys.patients_list_title.tr(),
        showBack: false,
        actions: [
          InkWell(
            onTap: () => push(NamedRoutes.profile),
            child: Container(
              width: AppSize.s45.w,
              decoration: BoxDecoration(
                color: context.surfaceColor,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(Assets.images.doctor.path),
                ),
              ),
            ),
          ).withPadding(end: AppSize.screenPadding.w),
        ],
      ),
      body: BlocBuilder<PatientsCubit, PatientsState>(
        bloc: cubit,
        builder: (context, state) => switch (state.status) {
          RequestState.initial ||
          RequestState.loading => Lottie.asset(
            Assets.lottieFiles.waiting.path,
          ).center,
          RequestState.error => CustomErrorWidget(
            title: state.msg,
            errorStatus: state.errorType,
            onTap: cubit.getPatients,
          ),
          RequestState.empty => Lottie.asset(
            Assets.lottieFiles.noResultFound.path,
          ).center,
          RequestState.done => RefreshIndicator.adaptive(
            color: context.primaryColor,
            onRefresh: cubit.getPatients,
            child: ListView.separated(
              padding: EdgeInsets.all(AppSize.screenPadding.w),
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemCount: state.patients.length,
              separatorBuilder: (_, _) => SizedBox(height: AppSize.s10.h),
              itemBuilder: (_, i) => PatientCard(
                patient: state.patients[i],
                onTap: () => _open(
                  NamedRoutes.patientDetails,
                  arg: {RouteString.patient: state.patients[i]},
                ),
              ),
            ),
          ),
        },
      ),
      bottomNavigationBar: AppButton(
        title: LocaleKeys.patients_add_new.tr(),
        height: AppSize.s70.h,
        radius: AppSize.radiusCard.r,
        onPressed: () => _open(NamedRoutes.addPatient),
      ).withPadding(
        start: AppSize.screenPadding.w,
        end: AppSize.screenPadding.w,
        bottom: AppSize.screenPadding.w,
      ),
    );
  }
}

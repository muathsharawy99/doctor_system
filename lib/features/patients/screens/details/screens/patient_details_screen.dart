import 'package:doctor/core/extensions/unified_extensions.dart';
import 'package:doctor/core/services/service_locator.dart';
import 'package:doctor/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/patient_model.dart';
import '../../../widgets/patient_form.dart';
import '../manager/patient_details_cubit.dart';
import '../manager/patient_details_state.dart';

/// Edit (save) or delete one patient.
class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key, required this.patient});

  final PatientModel patient;

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final PatientDetailsCubit cubit = sl<PatientDetailsCubit>();
  late final name = TextEditingController(text: widget.patient.name);
  late final dateOfBirth = TextEditingController(
    text: widget.patient.dateOfBirth,
  );
  late final diagnosis = TextEditingController(text: widget.patient.diagnosis);
  late final address = TextEditingController(text: widget.patient.address);
  late final visitTime = TextEditingController(text: widget.patient.visitTime);

  @override
  void dispose() {
    for (final c in [name, dateOfBirth, diagnosis, address, visitTime]) {
      c.dispose();
    }
    if (!cubit.isClosed) cubit.close();
    super.dispose();
  }

  void _save() => cubit.updatePatient(widget.patient.id, {
    'name': name.text,
    'date_of_birth': dateOfBirth.text,
    'diagnosis': diagnosis.text,
    'address': address.text,
    'visit_time': visitTime.text,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: LocaleKeys.patients_details_title.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSize.screenPadding.w),
          child: Column(
            children: [
              PatientForm(
                name: name,
                dateOfBirth: dateOfBirth,
                diagnosis: diagnosis,
                address: address,
                visitTime: visitTime,
              ),
              BlocConsumer<PatientDetailsCubit, PatientDetailsState>(
                bloc: cubit,
                listenWhen: (p, c) =>
                    p.saveStatus != c.saveStatus ||
                    p.deleteStatus != c.deleteStatus,
                listener: (context, state) {
                  if (state.saveStatus.isError || state.deleteStatus.isError) {
                    FlashHelper.showToast(state.msg);
                  }
                  if (state.saveStatus.isDone || state.deleteStatus.isDone) {
                    FlashHelper.showToast(state.msg, type: MessageType.success);
                    Navigator.maybePop(context);
                  }
                },
                builder: (context, state) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButton(
                      title: LocaleKeys.static_save.tr(),
                      width: AppSize.s150.w,
                      height: AppSize.s50.h,
                      radius: AppSize.s30.r,
                      color: context.successColor,
                      isLoading: state.saveStatus.isLoading,
                      onPressed: () {
                        if (!state.isBusy) _save();
                      },
                    ),
                    AppButton(
                      title: LocaleKeys.static_delete.tr(),
                      width: AppSize.s150.w,
                      height: AppSize.s50.h,
                      radius: AppSize.s30.r,
                      color: context.errorColor,
                      isLoading: state.deleteStatus.isLoading,
                      onPressed: () {
                        if (!state.isBusy) {
                          cubit.deletePatient(widget.patient.id);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

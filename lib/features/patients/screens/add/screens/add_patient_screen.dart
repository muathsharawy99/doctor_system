import 'package:doctor/core/extensions/unified_extensions.dart';
import 'package:doctor/core/services/service_locator.dart';
import 'package:doctor/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/patient_form.dart';
import '../manager/add_patient_cubit.dart';
import '../manager/add_patient_state.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final AddPatientCubit cubit = sl<AddPatientCubit>();
  final name = TextEditingController();
  final dateOfBirth = TextEditingController();
  final diagnosis = TextEditingController();
  final address = TextEditingController();
  final visitTime = TextEditingController();

  @override
  void dispose() {
    for (final c in [name, dateOfBirth, diagnosis, address, visitTime]) {
      c.dispose();
    }
    if (!cubit.isClosed) cubit.close();
    super.dispose();
  }

  void _add() => cubit.addPatient({
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
      appBar: CustomAppBar(title: LocaleKeys.patients_add_title.tr()),
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
              BlocConsumer<AddPatientCubit, AddPatientState>(
                bloc: cubit,
                listenWhen: (p, c) => p.status != c.status,
                listener: (context, state) {
                  if (state.status.isError) FlashHelper.showToast(state.msg);
                  if (state.status.isDone) {
                    FlashHelper.showToast(state.msg, type: MessageType.success);
                    Navigator.maybePop(context);
                  }
                },
                builder: (context, state) => AppButton(
                  title: LocaleKeys.patients_add.tr(),
                  width: AppSize.s300.w,
                  height: AppSize.s50.h,
                  radius: AppSize.s30.r,
                  color: context.primaryColor,
                  isLoading: state.status.isLoading,
                  onPressed: _add,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

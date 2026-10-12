import 'package:doctor/core/extensions/unified_extensions.dart';
import 'package:doctor/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Name, date of birth, diagnosis, address and visit time — labelled
/// fields shared by "add" and "details". Dates open a date picker.
class PatientForm extends StatelessWidget {
  const PatientForm({
    super.key,
    required this.name,
    required this.dateOfBirth,
    required this.diagnosis,
    required this.address,
    required this.visitTime,
  });

  final TextEditingController name, dateOfBirth, diagnosis, address, visitTime;

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController controller, {
    required DateTime first,
    required DateTime last,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.isAfter(last) ? last : now,
      firstDate: first,
      lastDate: last,
    );
    if (picked != null) controller.text = picked.toString();
  }

  @override
  Widget build(BuildContext context) {
    final gap = SizedBox(height: AppSize.s15.h);
    Widget label(String key) => Text(
      key.tr(),
      style: context.bold.copyWith(fontSize: FontSize.s20),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(LocaleKeys.patients_name),
        gap,
        AppField(controller: name, keyboardType: TextInputType.name),
        gap,
        label(LocaleKeys.patients_date_of_birth),
        gap,
        AppField(
          controller: dateOfBirth,
          keyboardType: TextInputType.none,
          readOnly: true,
          onTap: () => _pickDate(
            context,
            dateOfBirth,
            first: AppConstants.firstBirthDate,
            last: DateTime.now(),
          ),
        ),
        gap,
        label(LocaleKeys.patients_diagnosis),
        gap,
        AppField(controller: diagnosis),
        gap,
        label(LocaleKeys.patients_address),
        gap,
        AppField(controller: address, keyboardType: TextInputType.streetAddress),
        gap,
        label(LocaleKeys.patients_visit_time),
        gap,
        AppField(
          controller: visitTime,
          keyboardType: TextInputType.none,
          readOnly: true,
          onTap: () => _pickDate(
            context,
            visitTime,
            first: AppConstants.firstVisitDate,
            last: AppConstants.lastVisitDate,
          ),
        ),
        gap,
      ],
    );
  }
}

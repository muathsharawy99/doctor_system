import 'package:doctor/core/extensions/unified_extensions.dart';
import 'package:doctor/gen/assets.gen.dart';
import 'package:doctor/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/models/patient_model.dart';

/// Blue card: patient image + name, diagnosis, visit time and address.
class PatientCard extends StatelessWidget {
  const PatientCard({super.key, required this.patient, required this.onTap});

  final PatientModel patient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSize.radiusCard.r);
    final textStyle = context.regular.copyWith(color: context.onPrimary);
    Widget line(String value, String fallbackKey, {int maxLines = 1}) => Text(
      value.isEmpty ? fallbackKey.tr() : value,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: textStyle,
    );
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: context.primaryColor,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: SizedBox(
          height: AppSize.s175.h,
          child: Row(
            children: [
              Container(
                width: AppSize.s120.h,
                height: AppSize.s175.h,
                color: context.surfaceColor,
                child: CustomImage(
                  Assets.images.patient.path,
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    patient.name.isEmpty
                        ? LocaleKeys.patients_no_name.tr()
                        : patient.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.copyWith(
                      fontSize: FontSize.s18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  line(
                    patient.diagnosis,
                    LocaleKeys.patients_no_diagnosis,
                    maxLines: 2,
                  ),
                  line(patient.visitTime, LocaleKeys.patients_no_visit_time),
                  line(patient.address, LocaleKeys.patients_no_address),
                ],
              ).withPadding(all: AppSize.s10.w).expand(),
            ],
          ),
        ),
      ),
    );
  }
}

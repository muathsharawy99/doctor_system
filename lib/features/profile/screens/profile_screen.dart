import 'package:doctor/core/extensions/unified_extensions.dart';
import 'package:doctor/core/services/service_locator.dart';
import 'package:doctor/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/profile_cubit.dart';
import '../manager/profile_state.dart';

/// The signed-in doctor's data + logout. (Save isn't wired to the API yet.)
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileCubit cubit = sl<ProfileCubit>();
  final name = TextEditingController(text: UserModel.i.name);
  final password = TextEditingController(text: UserModel.i.password);
  final type = TextEditingController(text: UserModel.i.type);
  final title = TextEditingController(text: UserModel.i.title);
  final address = TextEditingController(text: UserModel.i.address);

  @override
  void dispose() {
    for (final c in [name, password, type, title, address]) {
      c.dispose();
    }
    if (!cubit.isClosed) cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gap = SizedBox(height: AppSize.s15.h);
    Widget label(String key) => Text(
      key.tr(),
      style: context.bold.copyWith(fontSize: FontSize.s20),
    );
    Widget field(String key, TextEditingController c, {bool obscure = false}) =>
        AppField(controller: c, label: key.tr(), obscure: obscure);
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: LocaleKeys.profile_title.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSize.screenPadding.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label(LocaleKeys.profile_name),
              gap,
              field(LocaleKeys.profile_name, name),
              gap,
              label(LocaleKeys.profile_password),
              gap,
              field(LocaleKeys.profile_password, password, obscure: true),
              gap,
              label(LocaleKeys.profile_type),
              gap,
              field(LocaleKeys.profile_type, type),
              gap,
              label(LocaleKeys.profile_title_field),
              gap,
              field(LocaleKeys.profile_title_field, title),
              gap,
              label(LocaleKeys.profile_address),
              gap,
              field(LocaleKeys.profile_address, address),
              gap,
              BlocConsumer<ProfileCubit, ProfileState>(
                bloc: cubit,
                listenWhen: (p, c) => p.logoutStatus != c.logoutStatus,
                listener: (context, state) {
                  if (state.logoutStatus.isError) {
                    FlashHelper.showToast(state.msg);
                  }
                  if (state.logoutStatus.isDone) {
                    FlashHelper.showToast(state.msg, type: MessageType.success);
                    pushAndRemoveUntil(NamedRoutes.register);
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
                      onPressed: () {},
                    ),
                    AppButton(
                      title: LocaleKeys.profile_logout.tr(),
                      width: AppSize.s150.w,
                      height: AppSize.s50.h,
                      radius: AppSize.s30.r,
                      color: context.errorColor,
                      isLoading: state.logoutStatus.isLoading,
                      onPressed: cubit.logout,
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

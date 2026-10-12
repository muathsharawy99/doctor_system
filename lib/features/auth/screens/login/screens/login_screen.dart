import 'package:doctor/core/extensions/unified_extensions.dart';
import 'package:doctor/core/services/service_locator.dart';
import 'package:doctor/gen/assets.gen.dart';
import 'package:doctor/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/role_tile.dart';
import '../manager/login_cubit.dart';
import '../manager/login_state.dart';

/// Doctor login. The admin side isn't ready yet ("coming soon").
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginCubit cubit = sl<LoginCubit>();
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    if (!cubit.isClosed) cubit.close();
    super.dispose();
  }

  void _login() {
    if (!cubit.state.hasRole) {
      FlashHelper.showToast(LocaleKeys.validations_select_type.tr());
      return;
    }
    if (!formKey.isValid) return;
    cubit.login(email: email.text, password: password.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      bloc: cubit,
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status.isError) FlashHelper.showToast(state.msg);
        if (state.status.isDone) {
          FlashHelper.showToast(state.msg, type: MessageType.success);
          pushAndRemoveUntil(NamedRoutes.patients);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: CustomAppBar(title: LocaleKeys.auth_login_title.tr()),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.only(
              start: AppSize.screenPadding.w,
              end: AppSize.screenPadding.w,
              top: AppSize.s30.w,
              bottom: AppSize.s30.h,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.s200.h,
                  child: Lottie.asset(Assets.lottieFiles.hello.path),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoleTile(
                      label: LocaleKeys.auth_role_doctor.tr(),
                      imagePath: Assets.images.doctor.path,
                      selected: state.isDoctor,
                      onTap: cubit.toggleDoctor,
                    ),
                    RoleTile(
                      label: LocaleKeys.auth_role_admin.tr(),
                      imagePath: Assets.images.admin.path,
                      selected: state.isAdmin,
                      onTap: cubit.toggleAdmin,
                    ),
                  ],
                ),
                SizedBox(height: AppSize.s20.h),
                if (state.isAdmin)
                  SizedBox(
                    height: AppSize.s200.h,
                    child: Lottie.asset(Assets.lottieFiles.soon.path),
                  )
                else ...[
                  AppField(
                    controller: email,
                    label: LocaleKeys.auth_email.tr(),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    clearable: true,
                    validator: Validator.notEmpty(
                      LocaleKeys.validations_empty_email,
                    ),
                  ),
                  SizedBox(height: AppSize.s20.h),
                  AppField(
                    controller: password,
                    label: LocaleKeys.auth_password.tr(),
                    keyboardType: TextInputType.visiblePassword,
                    validator: Validator.password,
                  ),
                ],
              ],
            ),
          ),
        ),
        bottomNavigationBar: AppButton(
          title: LocaleKeys.auth_login.tr(),
          isLoading: state.status.isLoading,
          onPressed: _login,
        ).withPadding(
          start: AppSize.screenPadding.w,
          end: AppSize.screenPadding.w,
          bottom: AppSize.screenPadding.w,
        ),
      ),
    );
  }
}

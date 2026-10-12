import 'package:doctor/core/extensions/unified_extensions.dart';
import 'package:doctor/core/services/service_locator.dart';
import 'package:doctor/gen/assets.gen.dart';
import 'package:doctor/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../manager/register_cubit.dart';
import '../manager/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterCubit cubit = sl<RegisterCubit>();
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final address = TextEditingController();

  @override
  void dispose() {
    for (final c in [name, email, password, address]) {
      c.dispose();
    }
    if (!cubit.isClosed) cubit.close();
    super.dispose();
  }

  void _register() {
    if (!formKey.isValid) return;
    cubit.register(
      name: name.text,
      email: email.text,
      password: password.text,
      address: address.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final gap = SizedBox(height: AppSize.s15.h);
    final link = context.bold.copyWith(color: context.primaryColor);
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: LocaleKeys.auth_create_account.tr(),
        showBack: false,
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        bloc: cubit,
        listenWhen: (p, c) => p.status != c.status,
        listener: (context, state) {
          if (state.status.isError) FlashHelper.showToast(state.msg);
          if (state.status.isDone) {
            FlashHelper.showToast(state.msg, type: MessageType.success);
            pushAndRemoveUntil(NamedRoutes.login);
          }
        },
        builder: (context, state) => Form(
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
                  height: AppSize.s175.h,
                  child: Lottie.asset(Assets.lottieFiles.hello.path),
                ),
                AppField(
                  controller: name,
                  label: LocaleKeys.auth_name.tr(),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  clearable: true,
                  validator: Validator.notEmpty(
                    LocaleKeys.validations_empty_name,
                  ),
                ),
                gap,
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
                gap,
                AppField(
                  controller: password,
                  label: LocaleKeys.auth_password.tr(),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  validator: Validator.password,
                ),
                gap,
                AppField(
                  controller: address,
                  label: LocaleKeys.auth_address.tr(),
                  keyboardType: TextInputType.streetAddress,
                  clearable: true,
                  validator: Validator.address,
                ),
                gap,
                AppButton(
                  title: LocaleKeys.auth_create_account.tr(),
                  isLoading: state.status.isLoading,
                  onPressed: _register,
                ),
                gap,
                Text(LocaleKeys.auth_have_account.tr(), style: context.regular),
                TextButton(
                  onPressed: () => push(NamedRoutes.login),
                  child: Text(
                    LocaleKeys.auth_login_now.tr(),
                    style: context.regular.copyWith(
                      fontSize: FontSize.s18,
                      color: context.primaryColor,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: context.regular,
                    children: [
                      TextSpan(text: LocaleKeys.auth_terms_prefix.tr()),
                      TextSpan(
                        text: LocaleKeys.auth_terms_services.tr(),
                        style: link,
                      ),
                      TextSpan(text: LocaleKeys.auth_terms_and.tr()),
                      TextSpan(
                        text: LocaleKeys.auth_terms_cookie.tr(),
                        style: link,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

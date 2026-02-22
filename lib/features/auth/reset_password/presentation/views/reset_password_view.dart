import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/widgets/auth_header.dart';

import '../../../../../core/framework/validator.dart';
import '../../../../../core/widgets/custome_button.dart';
import '../../../../../core/widgets/custome_labeld_field.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../data/arguments/password_arguments.dart';
import '../cubits/new_password_cubit/new_password_cubit.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.argument});
final PasswordArguments argument;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NewPasswordCubit>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKeyController,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 16.h),

                   AuthHeader(
                    title: LocaleKeys.resetPasswordTitle.tr(),
                    subTitle:
                    LocaleKeys.resetPasswordSubtitle.tr(),
                  ),

                  SizedBox(height: 46.h),

                  CustomLabeledField(
                    label: LocaleKeys.passwordLabel.tr(),
                    hintText: LocaleKeys.passwordHint.tr(),
                    isObscureText: true,
                    controller: cubit.passwordController,
                    validator: AppValidator.validatePassword,
                  ),
                  SizedBox(height: 16.h),

                  CustomLabeledField(
                    label: LocaleKeys.confirmPassword.tr(),
                    hintText: LocaleKeys.passwordHint.tr(),
                    isObscureText: true,
                    controller: cubit.confirmPasswordController,
                    validator: (value) =>
                        AppValidator.validateConfirmPassword(
                            value, cubit.passwordController.text),
                  ),

                  SizedBox(height: 32.h),

                  BlocBuilder<NewPasswordCubit, NewPasswordState>(
                    builder: (context, state) {
                      NewPasswordCubit cubit = BlocProvider.of<NewPasswordCubit>(context);
                      return CustomButton(
                        text: LocaleKeys.confirmPassword.tr(),
                        isLoading: state is NewPasswordLoadingState,
                        onPressed: state is NewPasswordLoadingState? null:
                           () async {
                          if (cubit.formKeyController.currentState!.validate()) {
                            cubit.newPassword(context,argument.email);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

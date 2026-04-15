import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import  'package:thamara/core/widgets/auth_header.dart';

import '../../../../../core/framework/validator.dart';
import '../../../../../core/widgets/custome_button.dart';
import '../../../../../core/widgets/custome_labeld_field.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../cubits/reset_password_cubit/reset_password_cubit.dart';

class PasswordRecoveryView extends StatelessWidget {
  const PasswordRecoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordCubit cubit = context.read<ResetPasswordCubit>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKeyController,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 24.h),
              child: Column(
                children: [

                   AuthHeader(
                    title: LocaleKeys.passwordRecoveryTitle.tr(),
                    subTitle:
                    LocaleKeys.passwordRecoverySubtitle.tr(),
                  ),

                  SizedBox(height: 46.h),

                  CustomLabeledField(
                    controller: cubit.emailController,
                    validator: AppValidator.validateEmail,
                    label: LocaleKeys.emailLabel.tr(),
                    hintText: LocaleKeys.emailHint.tr(),
                  ),
                  SizedBox(height: 32.h),
                  BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                      ResetPasswordCubit cubit = BlocProvider.of<ResetPasswordCubit>(context);
                      return AbsorbPointer(
                        absorbing: state is ResetPasswordLoadingState,
                        child: CustomButton(
                          text: LocaleKeys.recoverPasswordBtn.tr(),
                          isLoading: state is ResetPasswordLoadingState,
                          onPressed: () async {
                            if (cubit.formKeyController.currentState!.validate()) {
                              cubit.forgetPassword(context);
                            }
                          },
                        ),
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

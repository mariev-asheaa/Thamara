import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/extentions/navigation.dart';
import 'package:thamara/core/widgets/app_logo.dart';
import 'package:thamara/core/widgets/thamara_text.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:thamara/features/auth/login/presentation/widgets/terms_and_policy_text.dart';

import '../../../../core/framework/validator.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../core/widgets/custom_divider.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../core/widgets/custome_labeld_field.dart';
import '../../../../generated/locale_keys.g.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: cubit.loginFormKeyController,
              child: Column(
                children: [
                  SizedBox(height: 78.h),

                  const Hero(tag: 'logo', child: AppLogo()),

                  SizedBox(height: 25.h),

                  const Hero(tag: 'app_logo_text', child: ThamaraText()),

                  SizedBox(height: 41.h),

                  CustomLabeledField(
                    validator: AppValidator.validateEmail,
                    controller: cubit.loginEmailController,
                    label: LocaleKeys.emailLabel.tr(),
                    hintText: LocaleKeys.emailHint.tr(),
                  ),

                  SizedBox(height: 16.h),

                  CustomLabeledField(
                    validator: AppValidator.validatePassword,
                    controller: cubit.loginPasswordController,
                    label: LocaleKeys.passwordLabel.tr(),
                    hintText: LocaleKeys.passwordHint.tr(),
                    isObscureText: true,
                  ),
                  SizedBox(height: 8.h),

                  Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: () {
                        context.pushWithNamed(Routes.resetPasswordView);
                      },
                      child: Text(
                        LocaleKeys.forgotPassword.tr(),
                        style: TextStyleManager.font14Bold.copyWith(
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      final cubit = BlocProvider.of<LoginCubit>(context);
                      return CustomButton(
                        text: LocaleKeys.signInBtn.tr(),
                        isLoading: state is LoginLoadingState,
                        onPressed: state is LoginLoadingState
                            ? null
                            : () async {
                                if (cubit.loginFormKeyController.currentState
                                        ?.validate() ??
                                    false) {
                                  cubit.login(context);
                                }
                              },
                      );
                    },
                  ),
                  SizedBox(height: 25.h),

                  const CustomDivider(),
                  SizedBox(height: 16.h),

                  CustomButton(
                    text: LocaleKeys.createNewAccount.tr(),
                    isPrimary: false,
                    onPressed: () {
                      context.pushWithNamed(Routes.registerView);
                    },
                  ),

                  SizedBox(height: 196.h),

                  const TermsAndPolicyText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

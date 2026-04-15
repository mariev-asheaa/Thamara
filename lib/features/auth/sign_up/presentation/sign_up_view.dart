import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/extentions/navigation.dart';
import 'package:thamara/core/widgets/phone_field.dart';
import 'package:thamara/core/widgets/user_name_field.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/framework/validator.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/custome rich_text.dart';
import '../../../../core/widgets/thamara_text.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../core/widgets/custome_labeld_field.dart';
import '../../../../generated/locale_keys.g.dart';
import 'cubit/register_cubit.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return
      Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: cubit.registerFormKeyController,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:24.h,horizontal: 16.w),
                child: Column(
                  children: [

                    const AppLogo(),

                    SizedBox(height: 24.h),

                    const ThamaraText(),

                    SizedBox(height: 41.h),

                    UserNameFields(
                        firstNameController: cubit.registerFirstNameController,
                        secondNameController: cubit.registerLastNameController),
                    SizedBox(height: 16.h),

                    CustomLabeledField(
                      validator: AppValidator.validateEmail,
                      label:  LocaleKeys.emailLabel.tr(),
                      hintText: LocaleKeys.emailHint.tr(),
                      controller: cubit.registerEmailController,
                    ),

                    SizedBox(height: 16.h),
                    PhoneField(controller: cubit.registerPhoneController,),
                    SizedBox(height: 16.h),

                    CustomLabeledField(
                      validator: AppValidator.validatePassword,
                      controller: cubit.registerPasswordController,
                      label: LocaleKeys.passwordLabel.tr(),
                      hintText: LocaleKeys.passwordHint.tr(),
                      isObscureText: true,
                    ),
                    SizedBox(height: 16.h),

                    CustomLabeledField(
                      controller: cubit.registerConfirmPasswordController,
                      label: LocaleKeys.confirmPassword.tr(),
                      hintText: LocaleKeys.passwordHint.tr(),
                      isObscureText: true,
                      validator: (value) =>
                          AppValidator.validateConfirmPassword(
                              value, cubit.registerPasswordController.text),
                    ),
                    SizedBox(height: 40.h),
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        final cubit = BlocProvider.of<RegisterCubit>(context);
                        return CustomButton(text: LocaleKeys.signUpBtn.tr(),
                          isLoading: state is RegisterLoadingState,
                          onPressed: state is RegisterLoadingState ? null : () async {
                            if (cubit.registerFormKeyController.currentState?.validate() ?? false) {
                              cubit.register(context);
                            }
                          }
                          ,);
                      },
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.center,
                      child: CustomRichText(
                        text: LocaleKeys.alreadyHaveAccount.tr(),
                        actionText: LocaleKeys.signInLink.tr(),
                        onTap: () {
                          context.pop();
                        },
                      ),
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

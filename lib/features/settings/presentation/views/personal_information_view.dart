import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../core/widgets/custome_labeld_field.dart';
import '../../../../core/widgets/phone_field.dart';
import '../../../../core/widgets/user_name_field.dart';
import '../../../../generated/locale_keys.g.dart';
import '../widgets/delete_account_dialog.dart';

class PersonalInformationView extends StatefulWidget {
  const PersonalInformationView({super.key});

  @override
  State<PersonalInformationView> createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends State<PersonalInformationView> {
  bool isEditing = false;
  final firstNameController = TextEditingController(text: "Mohab");
  final lastNameController = TextEditingController(text: "Mohamed");
  final emailController = TextEditingController(text: "mohabmohamed@gmail.com");
  final phoneController = TextEditingController(text: "1558578054");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                CustomHeader(title: LocaleKeys.personalInfo.tr()),
                SizedBox(height: 32.h),
                UserNameFields(
                  firstNameController: firstNameController,
                  secondNameController: lastNameController,
                  enabled: isEditing,
                  backgroundColor: isEditing
                      ? AppColors.backgroundColor
                      : AppColors.neutralGrey,
                ),
                SizedBox(height: 24.h),
                CustomLabeledField(
                  label: LocaleKeys.emailLabel.tr(),
                  hintText: LocaleKeys.emailHint.tr(),
                  controller: emailController,
                  enabled: isEditing,
                  backgroundColor: isEditing
                      ? AppColors.backgroundColor
                      : AppColors.neutralGrey,
                ),
                SizedBox(height: 24.h),

                PhoneField(
                  controller: phoneController,
                  enabled: isEditing,
                  backgroundColor: isEditing
                      ? AppColors.backgroundColor
                      : AppColors.neutralGrey,
                ),
                SizedBox(height: 24.h),

                if (isEditing == false)
                  Column(
                    children: [
                      CustomButton(
                        text: LocaleKeys.editInfoBtn.tr(),
                        onPressed: () {
                          setState(() {
                            isEditing = true;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomButton(
                        text: LocaleKeys.deleteAccountBtn.tr(),
                        isPrimary: false,
                        textColor: AppColors.criticalColor,
                        borderColor: AppColors.criticalColor,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const DeleteAccountDialog(),
                          );
                        },
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      CustomButton(
                        text: LocaleKeys.save.tr(),
                        onPressed: () {
                          setState(() {
                            isEditing = false;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomButton(
                        text: LocaleKeys.cancel.tr(),
                        isPrimary: false,

                        onPressed: () {
                          setState(() {
                            isEditing = false;
                          });
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

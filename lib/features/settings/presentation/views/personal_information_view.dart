import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/settings/presentation/cubit/profile_cubit.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/custom_error.dart';
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
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    // Populate controllers if state is already ProfileSuccess
    final state = context.read<ProfileCubit>().state;
    if (state is ProfileSuccess) {
      _populateControllers(state);
    }

    context.read<ProfileCubit>().getProfileInfo();
  }

  void _populateControllers(ProfileSuccess state) {
    firstNameController.text = state.userModel.firstName ?? '';
    lastNameController.text = state.userModel.secondName ?? '';
    emailController.text = state.userModel.email ?? '';
    phoneController.text = state.userModel.phoneNumber ?? '';
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),

            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileSuccess) {
                  _populateControllers(state);
                }
              },
              builder: (context, state) {
                final cubit = context.read<ProfileCubit>();
                if (state is ProfileFailure) {
                  return Center(
                    child: CustomError(
                      error: state.errorMessage,
                      retry: () {
                        cubit.getProfileInfo();
                      },
                    ),
                  );
                } else if (state is ProfileSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeader(
                        title: LocaleKeys.personalInfo.tr(),
                        showArrow: true,
                      ),
                      SizedBox(height: 32.h),
                      UserNameFields(
                        firstNameHint: state.userModel.firstName,
                        secondNameHint: state.userModel.secondName,
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
                        hintText: state.userModel.email ?? '',
                        controller: emailController,
                        enabled: isEditing,
                        backgroundColor: isEditing
                            ? AppColors.backgroundColor
                            : AppColors.neutralGrey,
                      ),
                      SizedBox(height: 24.h),
                      PhoneField(
                        phoneHint: state.userModel.phoneNumber,
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
                                  builder: (context) =>
                                      const DeleteAccountDialog(),
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
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: 300.h),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

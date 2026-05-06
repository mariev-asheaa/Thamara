import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/extentions/navigation.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/custom_error.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../core/widgets/custome_labeld_field.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../../../core/widgets/phone_field.dart';
import '../../../../core/widgets/user_name_field.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubits/edit_profile_cubit/edit_profile_cubit.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import '../widgets/custom_account_dialog.dart';

class PersonalInformationView extends StatefulWidget {
  const PersonalInformationView({super.key});

  @override
  State<PersonalInformationView> createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends State<PersonalInformationView> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    context.read<EditProfileCubit>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final editCubit = context.read<EditProfileCubit>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
            child: BlocConsumer<EditProfileCubit, EditProfileState>(
              listener: (context, state) {
                if (state is EditProfileSuccess) {
                  setState(() => isEditing = false);
                }
              },
              builder: (context, editState) {
                if (editState is GetProfileFailure) {
                  return CustomEmptyWidget(
                    title:  editState.errorMessage,
                    subTitle:LocaleKeys.tryAgainInAMoment.tr(),
                    //  retry: () => editCubit.getUserInfo(),
                  );
                } else if (editState is GetProfileLoading) {
                  return Padding(
                    padding: EdgeInsets.only(top: 300.h),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  );
                } else {
                   return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeader(
                        title: LocaleKeys.personalInfo.tr(),
                        showArrow: true,
                      ),
                      SizedBox(height: 32.h),
                      UserNameFields(
                        firstNameHint: editCubit.userInfo?.firstName,
                        secondNameHint: editCubit.userInfo?.secondName,
                        firstNameController: editCubit.firstNameController,
                        secondNameController: editCubit.secondNameController,
                        enabled: isEditing,
                        backgroundColor: isEditing
                            ? AppColors.backgroundColor
                            : AppColors.neutralGrey,
                      ),
                      SizedBox(height: 24.h),
                      CustomLabeledField(
                        label: LocaleKeys.emailLabel.tr(),
                        hintText: editCubit.userInfo?.email ?? '',
                        controller: editCubit.emailController,
                        enabled: isEditing,
                        backgroundColor: isEditing
                            ? AppColors.backgroundColor
                            : AppColors.neutralGrey,
                      ),
                      SizedBox(height: 24.h),
                      PhoneField(
                        phoneHint: editCubit.userInfo?.phoneNumber,
                        controller: editCubit.phoneController,
                        enabled: isEditing,
                        backgroundColor: isEditing
                            ? AppColors.backgroundColor
                            : AppColors.neutralGrey,
                      ),
                      SizedBox(height: 24.h),
                      if (!isEditing)
                        Column(
                          children: [
                            CustomButton(
                              text: LocaleKeys.editInfoBtn.tr(),
                              onPressed: () {
                                setState(() => isEditing = true);
                              },
                            ),
                            SizedBox(height: 16.h),
                            BlocBuilder<ProfileCubit, ProfileState>(
                              builder: (context, profileState) {
                                final profileCubit =
                                    context.read<ProfileCubit>();
                                return CustomButton(
                                  text: LocaleKeys.logOut.tr(),
                                  isPrimary: false,
                                  textColor: AppColors.criticalColor,
                                  borderColor: AppColors.criticalColor,
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) =>
                                          BlocProvider.value(
                                        value: profileCubit,
                                        child: BlocBuilder<ProfileCubit,ProfileState>(
                                          builder: (context, state) {
                                            return AbsorbPointer(
                                              absorbing:
                                                  state is LogOutLoading,
                                              child: CustomAccountDialog(
                                                title: LocaleKeys.logOut.tr(),
                                                description: LocaleKeys.logOutDescription.tr(),
                                                confirmActionButtonText: LocaleKeys.logOut.tr(),
                                                onConfirm: () {
                                                  profileCubit.logOut(context: context);
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
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
                                  builder: (context) => CustomAccountDialog(
                                    title: LocaleKeys.deleteAccountTitle.tr(),
                                    description: LocaleKeys.deleteAccountSubtitle.tr(),
                                    confirmActionButtonText: LocaleKeys.deleteBtn.tr(),
                                    onConfirm: () {},
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      else
                        Column(
                          children: [
                            AbsorbPointer(
                              absorbing: editState is EditProfileLoading,
                              child: CustomButton(
                                text: LocaleKeys.save.tr(),
                                onPressed: () =>
                                    editCubit.editProfile(context),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            CustomButton(
                              text: LocaleKeys.cancel.tr(),
                              isPrimary: false,
                              onPressed: () {
                                setState(() => isEditing = false);
                              },
                            ),
                          ],
                        ),
                    ],
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

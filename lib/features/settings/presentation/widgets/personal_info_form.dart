import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/custome_labeld_field.dart';
import '../../../../core/widgets/phone_field.dart';
import '../../../../core/widgets/user_name_field.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubits/edit_profile_cubit/edit_profile_cubit.dart';

class PersonalInfoForm extends StatelessWidget {
  const PersonalInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();

    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (_, current) =>
          current is EditingStarted ||
          current is EditingCancelled ||
          current is EditProfileSuccess ||
          current is GetProfileSuccess,
      builder: (context, state) {
        final isEditing = cubit.isEditing;
        final fieldColor =
            isEditing ? AppColors.backgroundColor : AppColors.neutralGrey;

        return Column(
          children: [
            UserNameFields(
              firstNameHint: cubit.userInfo?.firstName,
              secondNameHint: cubit.userInfo?.secondName,
              firstNameController: cubit.firstNameController,
              secondNameController: cubit.secondNameController,
              enabled: isEditing,
              backgroundColor: fieldColor,
            ),
            SizedBox(height: 24.h),
            CustomLabeledField(
              label: LocaleKeys.emailLabel.tr(),
              hintText: cubit.userInfo?.email ?? '',
              controller: TextEditingController(),
              //enabled: isEditing,
              backgroundColor: fieldColor,
            ),
            SizedBox(height: 24.h),
            PhoneField(
              phoneHint: cubit.userInfo?.phoneNumber,
              controller: cubit.phoneController,
              enabled: isEditing,
              backgroundColor: fieldColor,
            ),
          ],
        );
      },
    );
  }
}

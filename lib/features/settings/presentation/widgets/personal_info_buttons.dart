import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'delete_account_button.dart';
import 'log_out_button.dart';

class PersonalInfoButtons extends StatelessWidget {
  const PersonalInfoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final editCubit = context.read<EditProfileCubit>();

    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (_, current) =>
          current is EditingStarted ||
          current is EditingCancelled ||
          current is EditProfileLoading ||
          current is EditProfileSuccess ||
          current is EditProfileFailure,
      builder: (context, state) {
        if (editCubit.isEditing) {
          return _EditModeButtons(isLoading: state is EditProfileLoading);
        }
        return const _ViewModeButtons();
      },
    );
  }
}

// ─── Edit mode (Save / Cancel) ────────────────────────────────────────────────

class _EditModeButtons extends StatelessWidget {
  const _EditModeButtons({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final editCubit = context.read<EditProfileCubit>();

    return Column(
      children: [
        AbsorbPointer(
          absorbing: isLoading,
          child: CustomButton(
            text: LocaleKeys.save.tr(),
            onPressed: () => editCubit.editProfile(context),
          ),
        ),
        SizedBox(height: 16.h),
        CustomButton(
          text: LocaleKeys.cancel.tr(),
          isPrimary: false,
          onPressed: editCubit.cancelEditing,
        ),
      ],
    );
  }
}

// ─── View mode (Edit info / Log out / Delete account) ────────────────────────

class _ViewModeButtons extends StatelessWidget {
  const _ViewModeButtons();

  @override
  Widget build(BuildContext context) {
    final editCubit = context.read<EditProfileCubit>();

    return Column(
      children: [
        CustomButton(
          text: LocaleKeys.editInfoBtn.tr(),
          onPressed: editCubit.startEditing,
        ),
        SizedBox(height: 16.h),
        const LogOutButton(),
        SizedBox(height: 16.h),
        const DeleteAccountButton(),
      ],
    );
  }
}

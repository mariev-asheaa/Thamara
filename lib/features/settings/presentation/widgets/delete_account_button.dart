import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import 'custom_account_dialog.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  static void _showDialog(BuildContext context, ProfileCubit profileCubit) {
    showDialog<void>(
      context: context,
      builder: (_) => CustomAccountDialog(
        title: LocaleKeys.deleteAccountTitle.tr(),
        description: LocaleKeys.deleteAccountSubtitle.tr(),
        confirmActionButtonText: LocaleKeys.deleteBtn.tr(),
        onConfirm: () => profileCubit.deleteAccount(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();

    return CustomButton(
      text: LocaleKeys.deleteAccountBtn.tr(),
      isPrimary: false,
      textColor: AppColors.criticalColor,
      borderColor: AppColors.criticalColor,
      onPressed: () => _showDialog(context, profileCubit),
    );
  }
}

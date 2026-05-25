import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubits/profile_cubit/profile_cubit.dart';
import 'custom_account_dialog.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  static void _showDialog(BuildContext context, ProfileCubit profileCubit) {
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (_) => BlocProvider.value(
        value: profileCubit,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (_, current) =>
          current is LogOutLoading || current is LogOutFailure,
          builder: (ctx, state) => AbsorbPointer(
            absorbing: state is LogOutLoading,
            child: CustomAccountDialog(
              title: LocaleKeys.logOut.tr(),
              description: LocaleKeys.logOutDescription.tr(),
              confirmActionButtonText: LocaleKeys.logOut.tr(),
              onConfirm: () => profileCubit.logOut(context: ctx),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();

    return CustomButton(
      text: LocaleKeys.logOut.tr(),
      isPrimary: false,
      textColor: AppColors.criticalColor,
      borderColor: AppColors.criticalColor,
      onPressed: () => _showDialog(context, profileCubit),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thamara/core/constants/app_assets.dart';
import '../../../../../core/widgets/custome_button.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../cubit/login_cubit.dart';

class SocialAuth extends StatelessWidget {
  const SocialAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoadingState;
        final cubit = context.read<LoginCubit>();
        return Column(
          children: [
            CustomButton(
              icon: SvgPicture.asset(AppAssets.google),
              text: LocaleKeys.sign_in_with_google.tr(),
              isPrimary: false,
              isLoading: isLoading,
              onPressed: isLoading
                  ? null
                  : () => cubit.loginWithGoogle(context),
            ),
            SizedBox(height: 16.h),
            CustomButton(
              icon: SvgPicture.asset(AppAssets.facebook),
              text: LocaleKeys.sign_in_with_facebook.tr(),
              isPrimary: false,
              isLoading: isLoading,
              onPressed: isLoading
                  ? null
                  : () => cubit.loginWithFacebook(context),
            ),
          ],
        );
      },
    );
  }
}

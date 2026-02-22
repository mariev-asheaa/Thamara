import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/auth/otp/presentation/widgets/otp_fields.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/auth_header.dart';
import '../../../../core/widgets/custome rich_text.dart';
import '../../../../generated/locale_keys.g.dart';
import '../data/arguments/otp_argument.dart';
import 'cubits/otp_cubit.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key, required this.argument});

  final OTPArgument argument;
  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  late OTPCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<OTPCubit>();
    cubit.updateEmail(widget.argument.email);
    cubit.updateUserId(widget.argument.userId??0);
  }

  void _onOtpCompleted(String value) {
    cubit.clearErrorState();
    cubit.oTPController.text = value;
    if (value.length == cubit.otpLength) {
      cubit.submitOtp(context, widget.argument.isRegisterOTP);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),

               AuthHeader(
                  title: LocaleKeys.otpTitle.tr(),
                  subTitle:
                  LocaleKeys.otpSubtitle.tr(),
                ),

                SizedBox(height: 46.h),
                BlocBuilder<OTPCubit, OTPState>(
                  builder: (context, state) {
                    if (state is OTPFailureState) {
                      cubit.oTPController.clear();
                    }
                    return OtpFields(
                      isError: state is OTPFailureState,
                       onCompleted: (value) => _onOtpCompleted(value),
                    );
                  },
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomRichText(
                    text: LocaleKeys.didntReceiveCode.tr(),
                    actionText: LocaleKeys.resendCode.tr(),
                    onTap: () {
                      context.read<OTPCubit>().resendOTP(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

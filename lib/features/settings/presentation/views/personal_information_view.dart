import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubits/edit_profile_cubit/edit_profile_cubit.dart';
import '../widgets/profile_body.dart';

class PersonalInformationView extends StatefulWidget {
  const PersonalInformationView({super.key});

  @override
  State<PersonalInformationView> createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends State<PersonalInformationView> {
  @override
  void initState() {
    super.initState();
    context.read<EditProfileCubit>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
            child: BlocBuilder<EditProfileCubit, EditProfileState>(
              buildWhen: (_, current) =>
                  current is GetProfileLoading ||
                  current is GetProfileSuccess ||
                  current is GetProfileFailure,
              builder: (context, state) {
                if (state is GetProfileFailure) {
                  return CustomEmptyWidget(
                    title: state.errorMessage,
                    subTitle: LocaleKeys.tryAgainInAMoment.tr(),
                  );
                }
                if (state is GetProfileLoading) {
                  return Padding(
                    padding: EdgeInsets.only(top: 300.h),
                    child: Center(
                      child: CircularProgressIndicator(color: AppColors.primaryColor),
                    ),
                  );
                }
                return const ProfileBody();
              },
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/widgets/common_header_content.dart';
import 'package:thamara/features/profile/presentation/widgets/profile_options.dart';
import '../../../core/color_manager/app_colors.dart';
import '../../../core/widgets/custom_header.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(child: CommonHeaderContent(title: 'Profile')),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  ProfileOptions(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

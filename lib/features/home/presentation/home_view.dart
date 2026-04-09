import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';
import 'package:thamara/features/home/presentation/widgets/capture_card.dart';
import 'package:thamara/features/home/presentation/widgets/instructions_card.dart';

import '../../../core/widgets/custom_divider.dart';
import '../../../core/widgets/custom_header.dart';
import '../../../core/widgets/custome_button.dart';
import '../../../generated/locale_keys.g.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ImagePicker picker = ImagePicker();
  File? selectedImage;
  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });

      print("saved successfully ${selectedImage!.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 78.h, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.goodMorning.tr(),
                      style: TextStyleManager.font26Bold.copyWith(color: AppColors.secondaryColor),
                    ),
                    Text(
                      'Mohab Mohamed 👋🏻',
                      style: TextStyleManager.font26Bold.copyWith(color: AppColors.mainBlack),
                    ),
                  ],
                ),


              SizedBox(height: 24.h),
              CaptureCard(onTap: () {
                pickImage(ImageSource.camera);

              }),

              SizedBox(height: 8.h),

              CustomDivider(lineColor: AppColors.primaryColor.withValues(alpha: 0.25),textColor:AppColors.primaryColor ,),

              SizedBox(height: 8.h),
              CustomButton(
                text: LocaleKeys.uploadFromGallery.tr(),
                backgroundColor: AppColors.lightGreen,
                textColor: AppColors.primaryColor,
                icon: SvgPicture.asset('assets/images/photos.svg'),
                onPressed: () {
                  pickImage(ImageSource.gallery);
                }
              ),
              SizedBox(height: 24.h),
              InstructionsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

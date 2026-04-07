import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';
import 'package:thamara/features/home/presentation/widgets/save_plant_action_buttons.dart';
import '../../../../core/widgets/custome_text_form_field.dart';
import '../../../../generated/locale_keys.g.dart';

class SavePlantOverlay extends StatelessWidget {
  SavePlantOverlay({super.key});

  final TextEditingController textEditingController = TextEditingController();

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w), // Distance from screen edges
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: SavePlantOverlay(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // We use a Column with MainAxisSize.min so the dialog only takes the height it needs
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.black),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.greyColor.withValues(alpha: .1),
                  child: Icon(Icons.info_outline, color: AppColors.greyColor, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.save_your_plant.tr(),
                        style: TextStyleManager.font18SemiBold.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        LocaleKeys.save_plant_desc.tr(),
                        style: TextStyleManager.font12Bold.copyWith(
                          color: const Color(0xFF757575),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // --- IMAGE ---
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                'assets/images/fruit_image.png',
                height: 180.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.h),
            // --- INPUT LABEL ---
            RichText(
              text: TextSpan(
                text: LocaleKeys.plant_name.tr(),
                style: TextStyleManager.font14Bold.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                ),
                children: [
                  TextSpan(text: " *", style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              hintText: LocaleKeys.plant_name_hint.tr(),
              controller: textEditingController,
            ),
            SizedBox(height: 24.h),
            SavePlantActionButtons(),
              ],
            ),
        ),
    );
  }
}
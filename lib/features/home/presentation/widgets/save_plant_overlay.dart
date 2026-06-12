import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';
import 'package:thamara/features/home/data/arguments/ai_feature_arguments.dart';
import 'package:thamara/features/home/presentation/widgets/plant_saved_dialog.dart';
import 'package:thamara/features/home/presentation/widgets/save_plant_action_buttons.dart';
import '../../../../core/dependency_injection/di.dart';
import '../../../../core/extentions/show_toast.dart';
import '../../../../core/widgets/close_overlay.dart';
import '../../../../core/widgets/custome_text_form_field.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubit/ai_feature_cubit.dart';

class SavePlantOverlay extends StatelessWidget {
  SavePlantOverlay({
    super.key,
    required this.arguments,
    required this.imagePath,
  });

  final AiFeatureArguments arguments;
  final String imagePath;
  final TextEditingController textEditingController = TextEditingController();

  static void show(BuildContext context, {
    required AiFeatureArguments arguments,
    required String imagePath,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) =>
          Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: SavePlantOverlay(arguments: arguments, imagePath: imagePath),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CloseOverlay(),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.greyColor.withValues(alpha: .1),
                  child: Icon(Icons.info_outline, color: AppColors.greyColor,
                      size: 20.sp),
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
              child: Image.file(
                File(imagePath),
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
                  TextSpan(text: " *",
                      style: TextStyle(color: Colors.red, fontSize: 16.sp)),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              hintText: LocaleKeys.plant_name_hint.tr(),
              controller: textEditingController,
            ),
            SizedBox(height: 24.h),
            BlocProvider(
              create: (context) => getIt<AiFeatureCubit>(),
              child: BlocListener<AiFeatureCubit, AiFeatureState>(
                listener: (context, state) {
                  if (state is AiReportLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is AiReportSuccess) {
                    // close loading
                    if (Navigator.canPop(context)) Navigator.pop(context);
                    // close SavePlantOverlay
                    if (Navigator.canPop(context)) Navigator.pop(context);
                    PlantSavedDialog.show(context);
                  }

                  if (state is AiReportError) {
                    if (Navigator.canPop(context)) Navigator.pop(context);
                    context.showToast(state.errorMessage, isError: true);
                  }
                },
                child: SavePlantActionButtons(
                  arguments: arguments,
                  imagePath: imagePath,
                  controller: textEditingController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


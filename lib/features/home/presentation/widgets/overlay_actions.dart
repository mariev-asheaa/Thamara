import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/features/home/data/arguments/ai_feature_arguments.dart';
import 'package:thamara/features/home/presentation/widgets/save_plant_overlay.dart';

import '../../../../generated/locale_keys.g.dart';
import '../cubit/ai_feature_cubit.dart';

class OverlayActions extends StatefulWidget {
  const OverlayActions({
    super.key,
    required this.arguments,
    required this.imagePath,
  });

  final AiFeatureArguments arguments;
  final String imagePath;

  @override
  State<OverlayActions> createState() => _OverlayActionsState();
}

class _OverlayActionsState extends State<OverlayActions> {
  final ImagePicker picker = ImagePicker();

  File? selectedImage;

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      setState(() {
        selectedImage = file;
      });

      context.read<AiFeatureCubit>().postPlantImage(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightGreen,
              foregroundColor: AppColors.lightGreen,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            ),
            onPressed: () {
              pickImage(ImageSource.camera);
            },
            child: Text(LocaleKeys.scan_again.tr(), style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            ),
            onPressed: () {
              SavePlantOverlay.show(
                context,
                arguments: widget.arguments,
                imagePath: widget.imagePath,
              );
            },
            child: Text(LocaleKeys.continueUse.tr(), style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.whiteColor)),
          ),
        ),
      ],
    );
  }
}

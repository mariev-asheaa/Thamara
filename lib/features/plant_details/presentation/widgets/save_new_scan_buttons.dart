import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/plant_details/data/arguments/ai_comparison_arguments.dart';
import 'package:thamara/features/plant_details/data/params/scan_params.dart';
import 'package:thamara/features/plant_details/presentation/cubit/plant_details_cubit.dart';
import 'package:thamara/features/home/presentation/widgets/plant_saved_dialog.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';

class SaveNewScanButtons extends StatelessWidget {
  const SaveNewScanButtons({
    super.key,
    required this.imagePath,
    required this.result,
    required this.plantId,
  });

  final String imagePath;
  final AiComparisonArguments result;
  final int plantId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlantDetailsCubit, PlantDetailsState>(
      listener: (context, state) {
        if (state is PostScanSuccess) {
          // Close the NewScanResult dialog first
          Navigator.of(context).pop();
          // Then show the success dialog
          PlantSavedDialog.show(
            context,
            savedMessage: 'Your new plant scan is saved Successfully!',
          );
        } else if (state is PostScanFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: AppColors.criticalColor,
            ),
          );
        }
      },
      child: BlocBuilder<PlantDetailsCubit, PlantDetailsState>(
        buildWhen: (prev, curr) =>
            curr is PostScanLoading ||
            curr is PostScanSuccess ||
            curr is PostScanFailure ||
            prev is PostScanLoading,
        builder: (context, state) {
          final isSaving = state is PostScanLoading;
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primaryColor),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: isSaving ? null : () => Navigator.pop(context),
                  child: Text(
                    LocaleKeys.back.tr(),
                    style: TextStyleManager.font16Bold.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  onPressed: isSaving
                      ? null
                      : () {
                          final scanParam = ScanParams(
                            progressStatus: result.progressStatus,
                            confidence: result.confidence,
                            image: imagePath,
                            progressLevel: _progressLevelFromStatus(
                              result.progressStatus,
                            ),
                          );
                          context.read<PlantDetailsCubit>().postScanResult(
                            scanParam,
                            plantId,
                          );
                        },
                  child: isSaving
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.whiteColor,
                          ),
                        )
                      : Text(
                          LocaleKeys.save.tr(),
                          style: TextStyleManager.font16Bold.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  int _progressLevelFromStatus(String status) {
    switch (status) {
      case 'Healed':
        return 100;
      case 'Improving':
        return 65;
      case 'Stable':
        return 40;
      case 'Worsening':
        return 20;
      default:
        return 10;
    }
  }
}

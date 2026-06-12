import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/extentions/navigation.dart';
import 'package:thamara/features/plant_details/data/models/scan_record_model.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/models/plants_model.dart';
import 'app_badge.dart';

class PlantCard extends StatelessWidget {
  final PlantsModel plantsModel;
  final ScanRecord? latestScan;

  const PlantCard({
    super.key,
    required this.plantsModel,
    this.latestScan,
  });

  @override
  Widget build(BuildContext context) {
    final statusText =
        latestScan?.progressStatus ?? plantsModel.status ?? '';

    final double? displayProgress = latestScan != null
        ? (latestScan!.progressLevel > 1
        ? latestScan!.progressLevel / 100.0
        : latestScan!.progressLevel.toDouble())
        : (plantsModel.progress != null
        ? (plantsModel.progress! > 1
        ? plantsModel.progress! / 100.0
        : plantsModel.progress!)
        : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plantsModel.date,
          style: TextStyleManager.font20Bold.copyWith(
            color: AppColors.mainBlack,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.neutralGrey,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                plantsModel.image,
                width: double.infinity,
                height: 300.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 300.h,
                  color: AppColors.neutralGrey,
                  child: const Icon(Icons.broken_image),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (displayProgress != null)...[
                     AppBadge(text: statusText)
                ],
                    SizedBox(height: 12.h),
                    Text(
                      plantsModel.name,
                      style: TextStyleManager.font20Bold.copyWith(
                        color: AppColors.mainBlack,
                      ),
                    ),
                    if (displayProgress != null) ...[
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.recoveryProgress.tr(),
                            style: TextStyleManager.font14Regular,
                          ),
                          Text(
                            '${(displayProgress * 100).toInt()}%',
                            style: TextStyleManager.font14Regular,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: LinearProgressIndicator(
                          value: displayProgress,
                          minHeight: 14.h,
                          backgroundColor: AppColors.whiteColor2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.success,
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 20.h),
                    CustomButton(
                      width: 376.w,
                      text: LocaleKeys.viewFullDetailsBtn.tr(),
                      onPressed: () {
                        context.pushWithNamed(
                          Routes.plantDetailsView,
                          arguments: plantsModel.id,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
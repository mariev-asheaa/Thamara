import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../generated/locale_keys.g.dart';
import '../views/plant_details_view.dart';
import 'app_badge.dart';
import '../../data/models/plant_model.dart';

class PlantCard extends StatelessWidget {
  final PlantModel plant;

  const PlantCard({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          plant.date,
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
              Image.asset(
                plant.image,
                width: double.infinity,
                height: 300.h,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBadge(text: plant.status),
                    SizedBox(height: 12.h),
                    Text(
                      plant.name,
                      style: TextStyleManager.font20Bold.copyWith(
                        color: AppColors.mainBlack,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.recoveryProgress.tr(),
                          style: TextStyleManager.font14Regular,
                        ),
                        Text(
                          '${(plant.progress * 100).toInt()}%',
                          style: TextStyleManager.font14Regular,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: LinearProgressIndicator(
                        value: plant.progress,
                        minHeight: 14.h,
                        backgroundColor: AppColors.whiteColor2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.success,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    CustomButton(
                      width: 376.w,
                      text: LocaleKeys.viewFullDetailsBtn.tr(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlantDetailsView(plant: plant),
                          ),
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

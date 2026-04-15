import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/plant%20details/presentation/widgets/plant_treatement.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/models/plant_model.dart';
import '../widgets/disease_details_section.dart';
import '../widgets/plant_details_bottom_bar.dart';
import '../widgets/plant_details_header.dart';
import '../widgets/plant_general_info.dart';
import '../widgets/scan_history_item.dart';

class PlantDetailsView extends StatelessWidget {
  final PlantModel plant;
  const PlantDetailsView({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: const PlantDetailsBottomBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PlantDetailsHeader(plant: plant),

                  Transform.translate(
                    offset: Offset(0, -40.h),

                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 24.h,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.r),
                          topRight: Radius.circular(24.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          PlantGeneralInfo(plant: plant),
                          SizedBox(height: 32.h),
                          DiseaseDetailsSection(plant: plant),
                          SizedBox(height: 32.h),
                          PlantTreatment(plant: plant),
                          SizedBox(height: 32.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.scanHistory.tr(),
                                style: TextStyleManager.font18Bold,
                              ),
                              Text(
                                '(${plant.scanHistory.length} ${LocaleKeys.scansCount.tr()})',
                                style: TextStyleManager.font12Medium.copyWith(
                                  color: AppColors.neutralGrey500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: plant.scanHistory.length,
                            itemBuilder: (context, index) {
                              final record = plant.scanHistory[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 24.h),
                                child: ScanHistoryItem(record: record),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

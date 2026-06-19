import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../plant_details/data/models/plants_model.dart';
import '../../../plant_details/data/models/scan_record_model.dart';
import '../../../plant_details/presentation/widgets/disease_details_section.dart';
import '../../../plant_details/presentation/widgets/plant_details_header.dart';
import '../../../plant_details/presentation/widgets/plant_general_info.dart';
import '../../../plant_details/presentation/widgets/plant_treatement.dart';
import '../../../plant_details/presentation/widgets/scan_history_item.dart';
import '../../../settings/presentation/widgets/custom_account_dialog.dart';
import '../cubit/plant_details_cubit.dart';

class PlantDetailsBody extends StatelessWidget {
  const PlantDetailsBody({super.key, required this.plant, this.latestScan, required this.history, required this.id});
final PlantsModel plant;
final ScanRecord? latestScan;
final List<ScanRecord> history;
final int id;
   void _showDialog(BuildContext context, PlantDetailsCubit plantDetailsCubit) {
    showDialog<void>(
      context: context,
      builder: (_) => CustomAccountDialog(
        title: LocaleKeys.deletePlantTitle.tr(),
        description: LocaleKeys.deletePlantSubtitle.tr(),
        confirmActionButtonText: LocaleKeys.deleteBtn.tr(),
        discard: LocaleKeys.keepPlantBtn.tr(),
        onConfirm: () => plantDetailsCubit.deletePlant(context, id: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plantDetailsCubit = context.read<PlantDetailsCubit>();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                PlantDetailsHeader(plantsModel: plant),
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
                        PlantGeneralInfo(
                          plantsModel: plant,
                          latestScan: latestScan,
                        ),
                        SizedBox(height: 32.h),
                        DiseaseDetailsSection(plantsModel: plant),
                        SizedBox(height: 32.h),
                        PlantTreatment(plantsModel: plant),
                        SizedBox(height: 32.h),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              LocaleKeys.scanHistory.tr(),
                              style: TextStyleManager.font18Bold,
                            ),
                            Text(
                              '(${history.length} ${LocaleKeys.scansCount.tr()})',
                              style: TextStyleManager.font12Medium
                                  .copyWith(
                                color: AppColors.neutralGrey500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        ListView.builder(
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: history.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                              EdgeInsets.only(bottom: 24.h),
                              child: ScanHistoryItem(
                                  record: history[index]),
                            );
                          },
                        ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          text: LocaleKeys.deletePlant.tr(),
                          isPrimary: false,
                          backgroundColor: AppColors.criticalColor,
                          borderColor: AppColors.criticalColor,
                          textColor: AppColors.whiteColor,
                          onPressed: () => _showDialog(context, plantDetailsCubit),
                        ),
                        SizedBox(height: 53.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

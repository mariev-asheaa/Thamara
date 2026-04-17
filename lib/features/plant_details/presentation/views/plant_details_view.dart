import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/plant_details/presentation/cubit/plant_details_cubit.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../core/widgets/custom_error.dart';
import '../../../../generated/locale_keys.g.dart';
import '../widgets/disease_details_section.dart';
import '../widgets/plant_details_bottom_bar.dart';
import '../widgets/plant_details_header.dart';
import '../widgets/plant_general_info.dart';
import '../widgets/plant_treatement.dart';
import '../widgets/scan_history_item.dart';

class PlantDetailsView extends StatefulWidget {
  final int plantId;
  const PlantDetailsView({super.key, required this.plantId});

  @override
  State<PlantDetailsView> createState() => _PlantDetailsViewState();
}

class _PlantDetailsViewState extends State<PlantDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<PlantDetailsCubit>().getPlantById(widget.plantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: const PlantDetailsBottomBar(),
      body: BlocBuilder<PlantDetailsCubit, PlantDetailsState>(
        builder: (context, state) {
          if (state is PlantDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is PlantDetailsFailure) {
            return Center(
              child: CustomError(
                error: state.errorMessage,
                retry: () {
                  context.read<PlantDetailsCubit>().getPlantById(widget.plantId);
                },
              ),
            );
          } else if (state is PlantDetailsByIdSuccess) {
            final plant = state.plant;
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
                                      '(${plant.scanHistory?.length} ${LocaleKeys.scansCount.tr()})',
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: plant.scanHistory?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final record = plant.scanHistory?[index];
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
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}


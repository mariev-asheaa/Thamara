import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/plant_details/data/models/scan_record_model.dart';
import 'package:thamara/features/plant_details/presentation/cubit/plant_details_cubit.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../core/widgets/custom_error.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/models/plants_model.dart';
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
  PlantsModel? _plant;
  List<ScanRecord>? _scanRecords;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<PlantDetailsCubit>();
    cubit.getPlantById(widget.plantId);
    cubit.getScanHistory(widget.plantId);
  }

  ScanRecord? _getLatestScan(List<ScanRecord>? scanHistory) {
    if (scanHistory == null || scanHistory.isEmpty) return null;
    ScanRecord latest = scanHistory.first;
    DateTime? latestDate = DateTime.tryParse(latest.date);
    for (int i = 1; i < scanHistory.length; i++) {
      final current = scanHistory[i];
      final currentDate = DateTime.tryParse(current.date);
      if (currentDate != null) {
        if (latestDate == null || currentDate.isAfter(latestDate)) {
          latest = current;
          latestDate = currentDate;
        }
      }
    }
    return latest;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlantDetailsCubit, PlantDetailsState>(
      listener: (context, state) {
        if (state is PlantDetailsByIdSuccess) {
          setState(() => _plant = state.plant);
        } else if (state is GetScanHistorySuccess) {
          setState(() => _scanRecords = state.records);
        }
      },
      child: BlocBuilder<PlantDetailsCubit, PlantDetailsState>(
        builder: (context, state) {
          if (_plant == null) {
            if (state is PlantDetailsLoading) {
              return Scaffold(
                backgroundColor: AppColors.backgroundColor,
                body: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            } else if (state is PlantDetailsFailure) {
              return Scaffold(
                backgroundColor: AppColors.backgroundColor,
                body: Center(
                  child: CustomError(
                    error: state.errorMessage,
                    retry: () {
                      context.read<PlantDetailsCubit>().getPlantById(widget.plantId);
                    },
                  ),
                ),
              );
            }
          }

          if (_plant != null) {
            final plant = _plant!;
            // Use the dedicated history list if available; fall back to embedded.
            final history = _scanRecords ?? plant.scanHistory ?? [];
            final latestScan = _getLatestScan(history);
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              bottomNavigationBar: PlantDetailsBottomBar(plantsModel: plant),
              body: Column(
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
          return const Scaffold(body: SizedBox.shrink());
        },
      ),
    );
  }
}

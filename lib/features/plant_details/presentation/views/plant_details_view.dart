import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thamara/features/plant_details/data/models/scan_record_model.dart';
import 'package:thamara/features/plant_details/presentation/cubit/plant_details_cubit.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/custom_error.dart';
import '../../data/models/plants_model.dart';
import '../widgets/plant_details_body.dart';
import '../widgets/plant_details_bottom_bar.dart';


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
          if (state is PlantDetailsFailure) {
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
          if (_plant == null) {
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            );
          }

          if (_plant != null) {
            final plant = _plant!;
            final history = _scanRecords ?? plant.scanHistory ?? [];
            final latestScan = _getLatestScan(history);
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              bottomNavigationBar: PlantDetailsBottomBar(plantsModel: plant),
              body: PlantDetailsBody(plant: plant, history: history,latestScan: latestScan, id: widget.plantId,)
            );
          }
          return const Scaffold(body: SizedBox.shrink());
        },
      ),
    );
  }
}

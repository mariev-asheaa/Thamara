import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';

import '../../../../core/widgets/custom_header.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/models/plant_model.dart';
import '../widgets/history_search_bar.dart';
import '../widgets/plant_card .dart';

class AllPlantsView extends StatelessWidget {
  const AllPlantsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PlantModel> plantsList = [
      PlantModel(
        name: 'Mango Plant',
        date: '5 February 2025',
        status: 'Improving',
        progress: 0.7,
        image: 'assets/images/mango plant.png',

        firstDetectionDate: '1 February 2025',
        confidenceLevel: 1,
        severityLevel: 'Low',
        diseaseName: 'Powdery Mildew',
        description: 'This is a fungal disease that affects many plants...',
        treatmentTitle: 'Spray with fungicides and remove infected leaves.',
        treatmentUsage: 'Apply once every 7 days',
        scanHistory: [
          ScanRecord(
            date: '12 Oct 2023',
            image: 'assets/images/mango plant.png',
            severityLevel: 'Medium',
            confidenceLevel: 0.92,
            progress: 0.6,
          ),
          ScanRecord(
            date: '05 Oct 2023',
            image: 'assets/images/mango plant.png',
            severityLevel: 'High',
            confidenceLevel: 0.88,
            progress: 0.3,
          ),
        ],
      ),
      PlantModel(
        name: 'Orange Plant',
        date: '2 February 2025',
        status: 'critical',
        progress: 1.0,
        image: 'assets/images/mango plant.png',
        firstDetectionDate: '1 February 2025',
        confidenceLevel: 1,
        severityLevel: 'Low',
        diseaseName: 'Powdery Mildew',
        description: 'This is a fungal disease that affects many plants...',
        treatmentTitle: 'Spray with fungicides and remove infected leaves.',
        treatmentUsage: 'Apply once every 7 days',
        scanHistory: [
          ScanRecord(
            date: '12 Oct 2023',
            image: 'assets/images/mango plant.png',
            severityLevel: 'Medium',
            confidenceLevel: 0.92,
            progress: 0.6,
          ),
          ScanRecord(
            date: '05 Oct 2023',
            image: 'assets/images/mango plant.png',
            severityLevel: 'High',
            confidenceLevel: 0.88,
            progress: 0.3,
          ),
        ],
      ),
      PlantModel(
        name: 'Mango Plant',
        date: '2 February 2025',
        status: 'critical',
        progress: 1.0,
        image: 'assets/images/mango plant.png',

        firstDetectionDate: '1 February 2025',
        confidenceLevel: 1,
        severityLevel: 'Low',
        diseaseName: 'Powdery Mildew',
        description: 'This is a fungal disease that affects many plants...',
        treatmentTitle: 'Spray with fungicides and remove infected leaves.',
        treatmentUsage: 'Apply once every 7 days',
        scanHistory: [
          ScanRecord(
            date: '12 Oct 2023',
            image: 'assets/images/mango plant.png',
            severityLevel: 'Medium',
            confidenceLevel: 0.92,
            progress: 0.6,
          ),
          ScanRecord(
            date: '05 Oct 2023',
            image: 'assets/images/mango plant.png',
            severityLevel: 'High',
            confidenceLevel: 0.88,
            progress: 0.3,
          ),
        ],
      ),
      PlantModel(
        name: 'Mango Plant',
        date: '4 February 2025',
        status: 'Improving',
        progress: 1.0,
        image: 'assets/images/mango plant.png',

        firstDetectionDate: '1 February 2025',
        confidenceLevel: 1,
        severityLevel: 'Low',
        diseaseName: 'Powdery Mildew',
        description: 'This is a fungal disease that affects many plants...',
        treatmentTitle: 'Spray with fungicides and remove infected leaves.',
        treatmentUsage: 'Apply once every 7 days',
        scanHistory: [],
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 24.h,
              left: 16.w,
              right: 16.w,
              bottom: 120.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(title: LocaleKeys.allPlantsTitle.tr()),

                SizedBox(height: 27.h),
                HistorySearchBar(),
                SizedBox(height: 24.h),

                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: plantsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 22.h),
                      child: PlantCard(plant: plantsList[index]),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/home/presentation/widgets/treatment_section.dart';
import 'package:thamara/features/home/presentation/widgets/uploaded_image_overlay_display.dart';

import 'disease_info.dart';
import 'overlay_actions.dart';
import 'overlay_header.dart';

class DiseaseAnalysisSheet extends StatelessWidget {
  const DiseaseAnalysisSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      builder: (context) => const DiseaseAnalysisSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            OverlayHeader(),
            SizedBox(height: 20.h),
            UploadedImageOverlayDisplay(),
            SizedBox(height: 20.h),
            DiseaseInfo(),
            SizedBox(height: 24.h),
            TreatmentSection(),
            SizedBox(height: 30.h),
            OverlayActions(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
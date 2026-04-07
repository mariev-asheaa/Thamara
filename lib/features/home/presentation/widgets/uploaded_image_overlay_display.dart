import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadedImageOverlayDisplay extends StatelessWidget {
  const UploadedImageOverlayDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return    ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        children: [
          Image.asset('assets/images/fruit_image.png'),
          // The Detection Red Box Overlay
          Positioned(
            top: 30.h,
            right: 80.w,
            child: Container(
              width: 60.w,
              height: 80.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 3),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

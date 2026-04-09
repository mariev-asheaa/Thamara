import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadedImageOverlayDisplay extends StatelessWidget {
  const UploadedImageOverlayDisplay({super.key, required this.image});
final String image;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        children: [
          Image.file(File(image), fit: BoxFit.cover,),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_manager/app_colors.dart';
import '../widgets/toast_widget.dart';

extension ThemesHelper on BuildContext {
void showToast(String message, {bool isError = false}) {
  final overlay = Overlay.of(this);
  late OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        bottom: 85.h,
        left: MediaQuery.sizeOf(context).width * 0.1,
        right: MediaQuery.sizeOf(context).width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: ToastWidget(
            message: message,
            color: isError
                ? const Color.fromARGB(255, 129, 8, 8)
                : AppColors.secondaryColor,
            onDisappear: () => overlayEntry.remove(),
          ),
        ),
      );
    },
  );

  overlay.insert(overlayEntry);
}
}

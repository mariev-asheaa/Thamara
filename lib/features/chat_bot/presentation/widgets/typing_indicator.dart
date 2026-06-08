import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color_manager/app_colors.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor2,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.blackColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          final animation = CurvedAnimation(
            parent: _controller,
            curve: Interval(i / 3, (i + 1) / 3, curve: Curves.easeInOut),
          );
          return AnimatedBuilder(
            animation: animation,
            builder: (_, __) => Transform.translate(
              offset: Offset(0, -6 * animation.value),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

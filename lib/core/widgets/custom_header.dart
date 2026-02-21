import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeader extends StatelessWidget {
  final Widget child;

  const CustomHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 172.h,
      width: MediaQuery.of(context).size.width,

      child: Stack(
        children: [
          Image.asset(
            'assets/images/appbar.png',
            width: MediaQuery.of(context).size.width,
            height: 172.h,
            fit: BoxFit.cover,
          ),

          Positioned(top: 78.h, left: 16.w, right: 16.w, child: child),
        ],
      ),
    );
  }
}

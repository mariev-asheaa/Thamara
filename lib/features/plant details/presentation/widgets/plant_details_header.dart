import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/extentions/navigation.dart';
import '../../data/models/plant_model.dart';

class PlantDetailsHeader extends StatelessWidget {
  final PlantModel plant;
  const PlantDetailsHeader({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          plant.image,
          width: double.infinity,
          height: 440.h,
          fit: BoxFit.cover,
        ),

        Positioned(
          top: 24.h,
          left: 16.w,
          right: 16.w,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: SvgPicture.asset(
                    'assets/images/back button.svg',
                    width: 38.w,
                    height: 38.h,
                  ),
                ),
            
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/images/add button.svg',
                    width: 38.w,
                    height: 38.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

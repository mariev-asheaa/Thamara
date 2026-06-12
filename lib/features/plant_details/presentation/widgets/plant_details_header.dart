import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/constants/app_assets.dart';
import 'package:thamara/features/plant_details/data/models/plants_model.dart';

import '../../../../core/extentions/navigation.dart';

class PlantDetailsHeader extends StatelessWidget {
  final PlantsModel plantsModel;
  const PlantDetailsHeader({super.key, required this.plantsModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          plantsModel.image,
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
                    AppAssets.backButton,
                    width: 38.w,
                    height: 38.h,
                  ),
                ),
            
                GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppAssets.addButton,
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/constants/app_assets.dart';
import 'package:thamara/features/plant_details/data/models/plants_model.dart';
import 'package:thamara/features/plant_details/presentation/cubit/plant_details_cubit.dart';
import 'package:thamara/features/plant_details/presentation/widgets/new_scan_result.dart';

import '../../../../core/dependency_injection/di.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../generated/locale_keys.g.dart';

class PlantDetailsBottomBar extends StatefulWidget {
  const PlantDetailsBottomBar({super.key, required this.plantsModel});

  final PlantsModel plantsModel;

  @override
  State<PlantDetailsBottomBar> createState() => _PlantDetailsBottomBarState();
}

class _PlantDetailsBottomBarState extends State<PlantDetailsBottomBar> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndAnalyze(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked == null) return;

    if (!mounted) return;
    context.read<PlantDetailsCubit>().analyzeProgress(
      oldImageUrl: widget.plantsModel.image,
      newImagePath: picked.path,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlantDetailsCubit, PlantDetailsState>(
      listener: (context, state) {
        if (state is AnalyzeProgressSuccess) {
          showDialog(
            context: context,
            builder: (_) =>
                BlocProvider(
                  create: (context) => getIt<PlantDetailsCubit>(),
                  child: NewScanResult(
                    imagePath: state.newImagePath,
                    result: state.result,
                    plantId: widget.plantsModel.id,
                  ),
                ),
          );
        } else if (state is AnalyzeProgressFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: AppColors.criticalColor,
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 24.h, bottom: 74, right: 16.w, left: 16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: BlocBuilder<PlantDetailsCubit, PlantDetailsState>(
          buildWhen: (prev, curr) =>
          curr is AnalyzeProgressLoading ||
              curr is AnalyzeProgressSuccess ||
              curr is AnalyzeProgressFailure ||
              prev is AnalyzeProgressLoading,
          builder: (context, state) {
            final isLoading = state is AnalyzeProgressLoading;
            return Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: 120.w,
                    text: LocaleKeys.uploadBtn.tr(),
                    textColor: AppColors.primaryColor,
                    icon: ClipRRect(
                      child: SvgPicture.asset(
                        AppAssets.upload,
                        width: 20.h,
                        height: 20.h,
                      ),
                    ),
                    backgroundColor: AppColors.lightGreen,
                    borderColor: AppColors.lightGreen,
                    onPressed: isLoading ? null : () =>
                        _pickAndAnalyze(ImageSource.gallery),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: isLoading
                      ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    onPressed: null,
                    child: SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  )
                      : CustomButton(
                    text: LocaleKeys.scan_again.tr(),
                    onPressed: () => _pickAndAnalyze(ImageSource.camera),
                    icon: ClipRRect(
                      child: SvgPicture.asset(
                        AppAssets.camera,
                        width: 20.h,
                        height: 20.h,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/extentions/show_toast.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';
import 'package:thamara/features/home/presentation/widgets/capture_card.dart';
import 'package:thamara/features/home/presentation/widgets/disease_analysis_sheet.dart';
import 'package:thamara/features/home/presentation/widgets/instructions_card.dart';
import 'package:thamara/features/home/presentation/widgets/no_disease_sheet.dart';

import '../../../core/widgets/custom_divider.dart';
import '../../../core/widgets/custom_header.dart';
import '../../../core/widgets/custome_button.dart';
import '../../../generated/locale_keys.g.dart';
import 'cubit/ai_feature_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ImagePicker picker = ImagePicker();
  File? selectedImage;

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      setState(() {
        selectedImage = file;
      });

      context.read<AiFeatureCubit>().postPlantImage(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AiFeatureCubit, AiFeatureState>(
      listener: (context, state) {
        if (state is AiFeatureLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)),
          );
        }
        if (state is AiFeatureSuccess) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          if(state.resultModel.severityLevel=='None'||state.resultModel.severityLevel=='Low'){
            NoDiseaseSheet.show(
                context,
                state.resultModel, selectedImage!.path
            );
          }
          else{
            DiseaseAnalysisSheet.show(
                context,
                state.resultModel, selectedImage!.path
            );
          }
        }

        if (state is AiFeatureError) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          context.showToast(state.errorMessage, isError: true);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.goodMorning.tr(),
                          style: TextStyleManager.font26Bold,
                        ),
                        Text(
                          'Mohab Mohamed 👋🏻',
                          style: TextStyleManager.font26Bold,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 24.h),

                        CaptureCard(
                          onTap: () {
                            pickImage(ImageSource.camera);
                          },
                        ),

                        SizedBox(height: 8.h),

                        CustomDivider(themeColor: AppColors.secondaryColor),

                        SizedBox(height: 8.h),

                        CustomButton(
                          text: LocaleKeys.uploadFromGallery.tr(),
                          backgroundColor: AppColors.lightGreen,
                          textColor: AppColors.secondaryColor,
                          icon: SvgPicture.asset('assets/images/gallery.svg'),
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                          },
                        ),

                        SizedBox(height: 24.h),
                        InstructionsCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
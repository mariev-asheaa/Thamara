import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/widgets/empty_widget.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubit/plant_details_cubit.dart';
import '../widgets/history_search_bar.dart';
import '../widgets/plant_card .dart';

class AllPlantsView extends StatefulWidget {
  const AllPlantsView({super.key});

  @override
  State<AllPlantsView> createState() => _AllPlantsViewState();
}

class _AllPlantsViewState extends State<AllPlantsView> {
  @override
  void initState() {
    super.initState();
    context.read<PlantDetailsCubit>().getAllPlants();
    context.read<PlantDetailsCubit>().getAllPlantsWithLatestScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 24.h,
              left: 16.w,
              right: 16.w,
              bottom: 120.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(title: LocaleKeys.allPlantsTitle.tr()),
                SizedBox(height: 27.h),
                HistorySearchBar(),
                SizedBox(height: 24.h),
                BlocBuilder<PlantDetailsCubit, PlantDetailsState>(
                  builder: (context, state) {
                    if (state is PlantDetailsLoading) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 100.h),
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    } else if (state is PlantDetailsFailure) {
                      return CustomEmptyWidget(
                        title: state.errorMessage,
                        subTitle: LocaleKeys.tryAgainInAMoment.tr(),
                      );
                    }
                    else if (state is PlantDetailsSuccess) {
                      if(state.plantsModel.isEmpty){
                        return CustomEmptyWidget(title:LocaleKeys.noSavedPlantsTitle.tr(), subTitle:  LocaleKeys.noSavedPlantsSubtitle.tr(),);
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.plantsModel.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 22.h),
                            child: PlantCard(
                                plantsModel: state.plantsModel[index],
                                latestScan: state.latestScans[state.plantsModel[index].id]
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

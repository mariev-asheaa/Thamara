import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/framework/validator.dart';
import '../../../../../core/widgets/custome_labeld_field.dart';
import '../../../../../generated/locale_keys.g.dart';
// ignore: must_be_immutable
class UserNameFields extends StatelessWidget {
   UserNameFields({super.key, required this.firstNameController,required this.secondNameController});
  TextEditingController firstNameController = TextEditingController();
   TextEditingController secondNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomLabeledField(
            validator: AppValidator.validateName,
            label: LocaleKeys.firstNameLabel.tr(),
            hintText: LocaleKeys.firstNameHint.tr(),
            controller: firstNameController,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: CustomLabeledField(
            validator: AppValidator.validateName,
            label: LocaleKeys.secondNameLabel.tr(),
            hintText: LocaleKeys.secondNameHint.tr(),
            controller: secondNameController,
          ),
        ),
      ],
    );
  }
}

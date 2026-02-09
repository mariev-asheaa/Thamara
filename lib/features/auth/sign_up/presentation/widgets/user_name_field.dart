import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/framework/validator.dart';
import '../../../../../core/widgets/custome_labeld_field.dart';
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
            label: 'First Name',
            hintText: 'First Name...',
            controller: firstNameController,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: CustomLabeledField(
            validator: AppValidator.validateName,
            label: 'Second Name',
            hintText: 'Second Name...',
            controller: secondNameController,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custome_labeld_field.dart';

class UserNameFields extends StatelessWidget {
  const UserNameFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomLabeledField(
            label: 'First Name',
            hintText: 'First Name...',
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: CustomLabeledField(
            label: 'Second Name',
            hintText: 'Second Name...',
          ),
        ),
      ],
    );
  }
}

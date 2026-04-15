import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';

import '../text_style_manager/text_style_manager.dart';
import 'custome_text_form_field.dart';
// ignore: must_be_immutable
class CustomLabeledField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? enabled;
  final Color? backgroundColor;
  TextEditingController controller = TextEditingController();
   CustomLabeledField({
    super.key,
    required this.label,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
     required this.controller, this.validator,
     this.enabled,
     this.backgroundColor,
  });

  @override
  State<CustomLabeledField> createState() => _CustomLabeledFieldState();
}

class _CustomLabeledFieldState extends State<CustomLabeledField> {
  late bool isPasswordHidden;

  void initState() {
    super.initState();
    isPasswordHidden = widget.isObscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyleManager.font14Bold),
        SizedBox(height: 8.h),

        CustomTextFormField(
          validator: widget.validator,
          controller: widget.controller,
          hintText: widget.hintText,
          enabled: widget.enabled,
          backgroundColor: widget.backgroundColor,
          isObscureText: isPasswordHidden,
          suffixIcon: widget.isObscureText == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                  child: Icon(
                    isPasswordHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.greyColor,
                  ),
                )
              : null,
        ),
      ],
    );
  }
}

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';
import 'package:thamara/generated/locale_keys.g.dart';
import '../../../../../core/framework/validator.dart';
import '../../../../../core/widgets/custome_text_form_field.dart';
// ignore: must_be_immutable
class PhoneField extends StatelessWidget {
   PhoneField({super.key,required this.controller});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.phoneNumber.tr(), style: TextStyleManager.font14Bold),
        SizedBox(height: 8.h),
        Row(
          children: [
            Container(
              height: 55.h,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.greyColor),
              ),
              child: CountryCodePicker(
                onChanged: (country) {
                  print(country.dialCode);
                },
                initialSelection: 'EG',
                favorite: const ['+20', 'EG'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                padding: EdgeInsets.zero,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: CustomTextFormField(
                hintText: 'EX: 1558578054',
                keyboardType: TextInputType.phone,
                controller: controller,
                validator: AppValidator.validatePhone,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

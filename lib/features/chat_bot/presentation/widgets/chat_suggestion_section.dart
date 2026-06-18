import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/chat_bot/presentation/widgets/suggestion_item.dart';

import '../../../../generated/locale_keys.g.dart';

class ChatSuggestionsSection extends StatelessWidget {
  final Function(String) onSuggestionClick;

  const ChatSuggestionsSection({super.key, required this.onSuggestionClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SuggestionItem(
            text: LocaleKeys.suggestion_1.tr(),
            onTap: (value) {
              onSuggestionClick(value);
            },
          ),
          SizedBox(height: 10.h),
          SuggestionItem(
            text: LocaleKeys.suggestion_2.tr(),
            onTap: (value) {
              onSuggestionClick(value);
            },
          ),
          SizedBox(height: 10.h),
          SuggestionItem(
            text: LocaleKeys.suggestion_3.tr(),
            onTap: (value) {
              onSuggestionClick(value);
            },
          ),
        ],
      ),
    );
  }
}

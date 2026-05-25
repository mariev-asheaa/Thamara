import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/chat%20bot/presentation/widgets/suggestion_item.dart';

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
            text: "Hello, What can you help me with?",
            onTap: (value) {
              onSuggestionClick(value);
            },
          ),
          SizedBox(height: 10.h),
          SuggestionItem(
            text: "How many times should I water my plant?",
            onTap: (value) {
              onSuggestionClick(value);
            },
          ),
          SizedBox(height: 10.h),
          SuggestionItem(
            text: "How much sunlight does my plant need?",
            onTap: (value) {
              onSuggestionClick(value);
            },
          ),
        ],
      ),
    );
  }
}

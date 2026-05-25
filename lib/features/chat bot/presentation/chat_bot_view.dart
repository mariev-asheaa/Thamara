import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/chat%20bot/presentation/widgets/chat_input_field.dart';
import 'package:thamara/features/chat%20bot/presentation/widgets/chat_suggestion_section.dart';
import 'package:thamara/features/chat%20bot/presentation/widgets/my_chat_bubble.dart';
import 'package:thamara/features/chat%20bot/presentation/widgets/welcome_section.dart';
import '../../../core/color_manager/app_colors.dart';
import '../../../core/widgets/custom_header.dart';
import '../data/models/chat_message.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController chatController = TextEditingController();
  final List<ChatMessage> messages = [];

  void sendMessage(String text) {
    setState(() {
      messages.add(ChatMessage(message: text, isUser: true));
    });
    chatController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 24.h, right: 16.w),
              child: const CustomHeader(showArrow: true),
            ),

            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const WelcomeSection(),

                    if (messages.isEmpty) ...[
                      SizedBox(height: 325.h),
                      ChatSuggestionsSection(
                        onSuggestionClick: (value) {
                          sendMessage(value);
                        },
                      ),
                    ] else ...[
                      SizedBox(height: 48.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return MyChatBubble(
                              message: messages[index].message,
                              isUser: messages[index].isUser,
                            );
                          },
                        ),
                      ),
                    ],

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.blackColor.withValues(alpha: 0.1),
            ),
            ChatInputField(
              controller: chatController,
              onSend: () {
                sendMessage(chatController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}

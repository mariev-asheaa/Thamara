import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/chat_bot/presentation/widgets/typing_indicator.dart';
import 'package:thamara/features/chat_bot/presentation/widgets/welcome_section.dart';

import '../../data/models/chat_message.dart';
import '../../data/models/message_list_model.dart';
import '../cubit/chat_bot_cubit.dart';
import 'chat_suggestion_section.dart';
import 'my_chat_bubble.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.messageListModel});
final MessageListModel messageListModel;
  @override
  Widget build(BuildContext context) {
     if (messageListModel.messages.isEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const WelcomeSection(),
            SizedBox(height: 325.h),
            ChatSuggestionsSection(onSuggestionClick: messageListModel.sendMessage),
            SizedBox(height: 24.h),
          ],
        ),
      );
    }

    // Wrap in BlocBuilder so itemCount reacts to loading state changes
    return BlocBuilder<ChatBotCubit, ChatBotState>(
      buildWhen: (p, c) => p.runtimeType != c.runtimeType,
      builder: (_, state) {
        final isLoading = state is ChatBotLoading;
        return ListView.builder(
          controller: messageListModel.scrollController,
          padding: EdgeInsets.fromLTRB(16.w, 48.h, 16.w, 24.h),
          // +1 for WelcomeSection header, +1 extra slot only when loading
          itemCount: messageListModel.messages.length + 1 + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == 0) return const WelcomeSection();

            final msgIndex = index - 1;
            if (msgIndex < messageListModel.messages.length) {
              return MyChatBubble(
                message: messageListModel.messages[msgIndex].message,
                isUser: messageListModel.messages[msgIndex].isUser,
              );
            }

            // Only reachable when isLoading == true
            return Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: TypingIndicator(),
              ),
            );
          },
        );
      },
    );
  }
}

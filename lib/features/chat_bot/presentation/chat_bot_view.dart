import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/chat_bot/data/models/message_list_model.dart';
import 'package:thamara/features/chat_bot/presentation/widgets/chat_input_field.dart';
import 'package:thamara/features/chat_bot/presentation/widgets/message_list.dart';
import '../../../core/color_manager/app_colors.dart';
import '../../../core/widgets/custom_header.dart';
import '../data/models/chat_message.dart';
import 'cubit/chat_bot_cubit.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final _scrollController = ScrollController();
  final _chatController = TextEditingController();
  final _messages = <ChatMessage>[];

  @override
  void dispose() {
    _scrollController.dispose();
    _chatController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    setState(() => _messages.add(ChatMessage(message: trimmed, isUser: true)));
    _chatController.clear();
    _scrollToBottom();
    context.read<ChatBotCubit>().askQuestion(text: trimmed);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onBotResponse(String message) {
    setState(() => _messages.add(ChatMessage(message: message, isUser: false)));
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBotCubit, ChatBotState>(
      listenWhen: (_, state) =>
          state is ChatBotSuccess || state is ChatBotFailure,
      listener: (_, state) => switch (state) {
        ChatBotSuccess(:final answer) => _onBotResponse(answer),
        ChatBotFailure(:final message) => _onBotResponse(message),
        _ => null,
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: true,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 24.h, right: 16.w),
                child: const CustomHeader(showArrow: true),
              ),
              Expanded(
                child: MessageList(
                  messageListModel: MessageListModel(
                    messages: _messages,
                    sendMessage: _sendMessage,
                    scrollController: _scrollController,
                  ),
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppColors.blackColor.withValues(alpha: 0.1),
              ),
              _buildInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput() {
    return BlocBuilder<ChatBotCubit, ChatBotState>(
      buildWhen: (p, c) => (p is ChatBotLoading) != (c is ChatBotLoading),
      builder: (_, state) {
        final isLoading = state is ChatBotLoading;
        return ChatInputField(
          controller: _chatController,
          onSend: isLoading ? () {} : () => _sendMessage(_chatController.text),
        );
      },
    );
  }
}

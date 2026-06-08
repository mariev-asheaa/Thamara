import 'package:flutter/cupertino.dart';

import 'chat_message.dart';

class MessageListModel {
  final List<ChatMessage> messages;
  final void Function(String) sendMessage;
  final ScrollController scrollController;

  MessageListModel({required this.messages, required this.sendMessage, required this.scrollController});

}
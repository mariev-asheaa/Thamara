part of 'chat_bot_cubit.dart';

@immutable
sealed class ChatBotState {}

final class ChatBotInitial extends ChatBotState {}

class ChatBotLoading extends ChatBotState {}

class ChatBotSuccess extends ChatBotState {
  final String answer;

  ChatBotSuccess({required this.answer});
}

class ChatBotFailure extends ChatBotState {
  final String message;

  ChatBotFailure({required this.message});
}
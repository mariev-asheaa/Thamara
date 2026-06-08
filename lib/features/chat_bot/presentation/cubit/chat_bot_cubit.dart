import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../data/repos/chat_bot_repo.dart';

part 'chat_bot_state.dart';

@injectable
class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit(this.repository) : super(ChatBotInitial());
  final ChatBotRepository repository;

  Future<void> askQuestion({required String text, int limit = 5}) async {
    if (text.trim().isEmpty) return;

    emit(ChatBotLoading());
      final answer = await repository.getAnswer(text: text, limit: limit);
      answer.fold(
            (failure) => emit(ChatBotFailure(message: failure.errMessage)),
            (answer) => emit(ChatBotSuccess(answer: answer)),
      );
  }

  void reset() => emit(ChatBotInitial());
}

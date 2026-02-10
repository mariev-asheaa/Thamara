part of 'new_password_cubit.dart';

@immutable
sealed class NewPasswordState {}

final class NewPasswordInitialState extends NewPasswordState {}

final class NewPasswordLoadingState extends NewPasswordState {}

class NewPasswordSuccessState extends NewPasswordState {}

class NewPasswordFailureState extends NewPasswordState {
  final String errorMessage;
  NewPasswordFailureState({required this.errorMessage});
}

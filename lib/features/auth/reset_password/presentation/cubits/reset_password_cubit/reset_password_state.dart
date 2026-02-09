part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitialState extends ResetPasswordState {}

final class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordSuccessState extends ResetPasswordState {}

class ResetPasswordFailureState extends ResetPasswordState {
  final String errorMessage;
  ResetPasswordFailureState({required this.errorMessage});
}

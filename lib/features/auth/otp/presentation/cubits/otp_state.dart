part of 'otp_cubit.dart';

@immutable
sealed class OTPState {}

final class OTPInitial extends OTPState {}

class OTPLoadingState extends OTPState {}

class OTPSuccessState extends OTPState {
  OTPSuccessState();
}

class OTPFailureState extends OTPState {
  final String errorMessage;
  OTPFailureState({required this.errorMessage});
}

class OTPResendLoadingState extends OTPState {}

class OTPResendSuccessState extends OTPState {
  OTPResendSuccessState();
}

class OTPResendFailureState extends OTPState {
  final String errorMessage;
  OTPResendFailureState({required this.errorMessage});
}

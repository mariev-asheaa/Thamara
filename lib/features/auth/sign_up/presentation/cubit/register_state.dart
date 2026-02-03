part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailureState extends RegisterState {
  final String errorMessage;
  RegisterFailureState({required this.errorMessage});
}
part of 'edit_profile_cubit.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {}

final class EditProfileFailure extends EditProfileState {
  final String errorMessage;
  const EditProfileFailure({required this.errorMessage});
}

final class GetProfileLoading extends EditProfileState {}

final class GetProfileSuccess extends EditProfileState {}

final class GetProfileFailure extends EditProfileState {
  final String errorMessage;
  const GetProfileFailure({required this.errorMessage});
}

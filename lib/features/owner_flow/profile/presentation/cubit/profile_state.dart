part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfileEntity user;
  ProfileLoaded(this.user);
}

class ProfileUpdated extends ProfileState {
  final UserProfileEntity user;
  ProfileUpdated(this.user);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
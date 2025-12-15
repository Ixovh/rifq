part of 'provider_profile_cubit.dart';

abstract class ProviderProfileState {}

class ProviderProfileInitial extends ProviderProfileState {}

class ProviderProfileLoading extends ProviderProfileState {}

class ProviderProfileLoaded extends ProviderProfileState {
  final ProviderProfileEntity provider;
  ProviderProfileLoaded(this.provider);
}

class ProviderProfileUpdated extends ProviderProfileState {
  final ProviderProfileEntity provider;
  ProviderProfileUpdated(this.provider);
}

class ProviderProfileImageUploaded extends ProviderProfileState {
  final String imageUrl;
  ProviderProfileImageUploaded(this.imageUrl);
}

class ProviderProfileError extends ProviderProfileState {
  final String message;
  ProviderProfileError(this.message);
}

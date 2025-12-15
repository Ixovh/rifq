part of 'provider_auth_cubit.dart';

abstract class ProviderAuthState extends Equatable {
  const ProviderAuthState();

  @override
  List<Object> get props => [];
}

class ProviderAuthInitial extends ProviderAuthState {}

class ProviderAuthLoadingState extends ProviderAuthState {}

class ProviderAuthSuccessState extends ProviderAuthState {}

class ProviderAuthErrorState extends ProviderAuthState {
  final String msg;
  const ProviderAuthErrorState(this.msg);

  @override
  List<Object> get props => [msg];
}

class ProviderAuthSignUPSuccessState extends ProviderAuthState {}

class ProviderAuthLoginSuccessState extends ProviderAuthState {}

class ProviderAuthVerifyAccountSuccessState extends ProviderAuthState {}

class ProviderAuthLogoutSuccessState extends ProviderAuthState {}

class ProviderAuthPasswordResetEmailSentState extends ProviderAuthState {
  final String email;
  const ProviderAuthPasswordResetEmailSentState(this.email);

  @override
  List<Object> get props => [email];
}

class ProviderAuthPasswordResetSuccessState extends ProviderAuthState {}

class ProviderAuthServiceTypesSelectedSuccessState extends ProviderAuthState {}

class ProviderAuthServiceItemAddedSuccessState extends ProviderAuthState {}

class ProviderAuthServiceTypesSelectionState extends ProviderAuthState {
  final Set<int> selectedServiceTypes;
  final String providerId;
  final bool isLoadingProviderId;

  const ProviderAuthServiceTypesSelectionState({
    required this.selectedServiceTypes,
    required this.providerId,
    this.isLoadingProviderId = false,
  });

  @override
  List<Object> get props => [
    selectedServiceTypes,
    providerId,
    isLoadingProviderId,
  ];
}

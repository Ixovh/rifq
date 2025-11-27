part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}


class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthSignUPSuccessState extends AuthState {}

class AuthAnonymousSuccessState extends AuthState {}

class AuthLogoutSuccessState extends AuthState {}

// Error state
class AuthErrorState extends AuthState {
  final String msg;

  const AuthErrorState({required this.msg});

  @override
  List<Object> get props => [msg];
}
import 'package:equatable/equatable.dart';

abstract class ProviderNavState extends Equatable {
  const ProviderNavState();

  @override
  List<Object?> get props => [];
}

class ProviderNavInitialState extends ProviderNavState {}

class ProviderNavLoadingState extends ProviderNavState {}

class ProviderNavLoadedState extends ProviderNavState {}

class ProviderNavErrorState extends ProviderNavState {
  final String message;
  const ProviderNavErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

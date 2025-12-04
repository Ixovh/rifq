// lib/features/owner_flow/home/presentation/cubit/home_state.dart

part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeGuestState extends HomeState {
  const HomeGuestState();
}

class HomeLoaded extends HomeState {
  final String username;
  final List<PetModel> pets;

  const HomeLoaded({
    required this.username,
    required this.pets,
  });

  @override
  List<Object?> get props => [username, pets];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

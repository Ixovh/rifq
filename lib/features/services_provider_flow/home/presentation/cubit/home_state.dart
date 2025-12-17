part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final int? serviceTypeId; // 1 for clinic, 4 for boarding
  final List<ProviderReservationEntity> reservations;
  final String providerId;

  const HomeLoaded({
    required this.serviceTypeId,
    required this.reservations,
    required this.providerId,
  });

  @override
  List<Object> get props => [serviceTypeId ?? 0, reservations, providerId];

  bool get isClinic => serviceTypeId == 1;
  bool get isBoarding => serviceTypeId == 4;
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

class ReservationActionLoading extends HomeState {
  final int? serviceTypeId;
  final List<ProviderReservationEntity> reservations;
  final String providerId;

  const ReservationActionLoading({
    required this.serviceTypeId,
    required this.reservations,
    required this.providerId,
  });

  @override
  List<Object> get props => [serviceTypeId ?? 0, reservations, providerId];

  bool get isClinic => serviceTypeId == 1;
  bool get isBoarding => serviceTypeId == 4;
}

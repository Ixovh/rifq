part of 'clinic_cubit.dart';

abstract class ClinicState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ClinicInitial extends ClinicState {}

class ClinicLoading extends ClinicState {}

class ClinicGuestState extends ClinicState {
  final List<ProviderEntity> clinics;

  ClinicGuestState({this.clinics = const []});

  @override
  List<Object?> get props => [clinics];
}

class ClinicScreenLoaded extends ClinicState {
  final List<PetModel> pets;
  final List<ProviderEntity> clinics;

  ClinicScreenLoaded({
    required this.pets,
    required this.clinics,
  });

  @override
  List<Object?> get props => [pets, clinics];
}

class ClinicError extends ClinicState {
  final String message;

  ClinicError(this.message);

  @override
  List<Object?> get props => [message];
}

//!!---------------------CLINIC DETAILS STATE-----------------------------
class ClinicDetailsLoaded extends ClinicState {
  final List<ProviderItemsViewEntity> details;

  ClinicDetailsLoaded(this.details);

  @override
  List<Object?> get props => [details];
}
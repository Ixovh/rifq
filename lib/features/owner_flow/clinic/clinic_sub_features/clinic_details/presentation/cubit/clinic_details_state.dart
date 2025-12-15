
part of 'clinic_details_cubit.dart';


abstract class ClinicDetailsState {}

class ClinicDetailsLoading extends ClinicDetailsState {}

class ClinicDetailsLoaded extends ClinicDetailsState {
  final ProviderItemsViewEntity entity;
  ClinicDetailsLoaded(this.entity);
}

class ClinicDetailsError extends ClinicDetailsState {
  final String message;
  ClinicDetailsError(this.message);
}

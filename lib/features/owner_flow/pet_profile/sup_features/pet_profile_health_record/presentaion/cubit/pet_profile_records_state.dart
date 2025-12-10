part of 'pet_profile_records_cubit.dart';

@immutable
sealed class PetProfileRecordsState {}

final class PetProfileRecordsInitial extends PetProfileRecordsState {}

class PetProfileLoading extends PetProfileRecordsState {}

class PetProfileLoaded  extends PetProfileRecordsState {
  final PetEntity petent;
  final List<HealthRecordEntity> healthRecords;
  final List<ReservationEntity> reservations;
  PetProfileLoaded({
    required this.petent,
    required this.healthRecords,
    required this.reservations,
});
}

class PetProfileError  extends PetProfileRecordsState {
  final String massege;
  PetProfileError({required this.massege});
}

class AddingHealthRecord extends PetProfileRecordsState {}

class HealthRecordAddedSuccess extends PetProfileRecordsState {}

class HealthRecordAddError extends PetProfileRecordsState {
  final String masseg;
  HealthRecordAddError({required this.masseg});
}


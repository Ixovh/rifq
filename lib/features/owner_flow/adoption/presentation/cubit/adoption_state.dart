part of 'adoption_cubit.dart';

abstract class AdoptionState extends Equatable {
  const AdoptionState();

  @override
  List<Object> get props => [];
}

class AdoptionInitial extends AdoptionState {}

// ========== Loading States ==========
class AdoptionLoading extends AdoptionState {}

// ========== For Adoption Tab States ==========
class PetsForAdoptionLoaded extends AdoptionState {
  final List<AddPetEntity> pets;

  const PetsForAdoptionLoaded(this.pets);

  @override
  List<Object> get props => [pets];
}

class PetDetailsLoaded extends AdoptionState {
  final AddPetEntity pet;

  const PetDetailsLoaded(this.pet);

  @override
  List<Object> get props => [pet];
}

class AdoptionRequestSent extends AdoptionState {
  final AdoptionRequestEntity request;

  const AdoptionRequestSent(this.request);

  @override
  List<Object> get props => [request];
}

// ========== My Pets Tab States ==========
class MyPetsLoaded extends AdoptionState {
  final List<AddPetEntity> pets;
  final Map<String, String?> ownerNames;
  final Map<String, int> requestCounts;

  const MyPetsLoaded(
    this.pets, {
    this.ownerNames = const {},
    this.requestCounts = const {},
  });

  @override
  List<Object> get props => [pets, ownerNames, requestCounts];
}

class PetAddedForAdoption extends AdoptionState {}

class PetRemovedFromAdoption extends AdoptionState {}

class AdoptionRequestsLoaded extends AdoptionState {
  final List<AdoptionRequestEntity> requests;

  const AdoptionRequestsLoaded(this.requests);

  @override
  List<Object> get props => [requests];
}

class AdoptionRequestsByPetLoaded extends AdoptionState {
  final List<AdoptionRequestEntity> requests;

  const AdoptionRequestsByPetLoaded(this.requests);

  @override
  List<Object> get props => [requests];
}

class AdoptionRequestAccepted extends AdoptionState {}

class AdoptionRequestRejected extends AdoptionState {}

// ========== Additional States ==========
class AdoptionCancelled extends AdoptionState {}

class AdoptedPetsLoaded extends AdoptionState {
  final List<AddPetEntity> pets;

  const AdoptedPetsLoaded(this.pets);

  @override
  List<Object> get props => [pets];
}

class CancelledAdoptionsLoaded extends AdoptionState {
  final List<AdoptionRequestEntity> adoptions;

  const CancelledAdoptionsLoaded(this.adoptions);

  @override
  List<Object> get props => [adoptions];
}

// ========== Error State ==========
class AdoptionError extends AdoptionState {
  final String message;

  const AdoptionError(this.message);

  @override
  List<Object> get props => [message];
}

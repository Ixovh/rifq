part of 'adoption_cubit.dart';

abstract class AdoptionState extends Equatable {
  const AdoptionState();

  @override
  List<Object?> get props => [];
}

class AdoptionInitial extends AdoptionState {}

class AdoptionLoading extends AdoptionState {}

class AdoptionError extends AdoptionState {
  final String message;

  const AdoptionError(this.message);

  @override
  List<Object?> get props => [message];
}

/// All available pets for adoption (for users)
class AvailablePetsLoaded extends AdoptionState {
  final List<AddPetEntity> pets;

  const AvailablePetsLoaded(this.pets);

  @override
  List<Object?> get props => [pets];
}

/// Details for a single pet (for users or owners)
class PetDetailsLoaded extends AdoptionState {
  final AddPetEntity pet;

  const PetDetailsLoaded(this.pet);

  @override
  List<Object?> get props => [pet];
}

class MyPetsAndOfferedLoaded extends AdoptionState {
  final List<AddPetEntity> allPets;
  final List<AddPetEntity> offeredPets;

  const MyPetsAndOfferedLoaded({
    required this.allPets,
    required this.offeredPets,
  });

  @override
  List<Object?> get props => [allPets, offeredPets];
}

/// Pet successfully added for adoption (owner)
class PetAddedForAdoptionSuccess extends AdoptionState {
  final AddPetEntity pet;

  const PetAddedForAdoptionSuccess(this.pet);

  @override
  List<Object?> get props => [pet];
}

/// Pet removed from adoption (owner)
class PetRemovedFromAdoptionSuccess extends AdoptionState {
  final String petId;

  const PetRemovedFromAdoptionSuccess(this.petId);

  @override
  List<Object?> get props => [petId];
}

/// Pet owner's pets loaded (to choose which one to offer for adoption)
class MyPetsLoaded extends AdoptionState {
  final List<AddPetEntity> pets;

  const MyPetsLoaded(this.pets);

  @override
  List<Object?> get props => [pets];
}

/// Pet owner's pets that are currently offered for adoption loaded
class OfferedPetsLoaded extends AdoptionState {
  final List<AddPetEntity> pets;

  const OfferedPetsLoaded(this.pets);

  @override
  List<Object?> get props => [pets];
}

/// Number of requests for a single pet
class PetRequestCountLoaded extends AdoptionState {
  final String petId;
  final int count;

  const PetRequestCountLoaded({required this.petId, required this.count});

  @override
  List<Object?> get props => [petId, count];
}

/// All requests for a specific pet
class PetRequestsLoaded extends AdoptionState {
  final String petId;
  final List<AdoptionRequestEntity> requests;

  const PetRequestsLoaded({required this.petId, required this.requests});

  @override
  List<Object?> get props => [petId, requests];
}

/// Request status changed (accepted / rejected by owner)
class AdoptionRequestStatusUpdated extends AdoptionState {
  final AdoptionRequestEntity request;

  const AdoptionRequestStatusUpdated(this.request);

  @override
  List<Object?> get props => [request];
}

/// User sent a new adoption request
class AdoptionRequestSent extends AdoptionState {
  final AdoptionRequestEntity request;

  const AdoptionRequestSent(this.request);

  @override
  List<Object?> get props => [request];
}

/// User sees all their own requests
class UserAdoptionRequestsLoaded extends AdoptionState {
  final List<AdoptionRequestEntity> requests;

  const UserAdoptionRequestsLoaded(this.requests);

  @override
  List<Object?> get props => [requests];
}

/// User cancelled one of their requests
class AdoptionRequestCancelled extends AdoptionState {
  final AdoptionRequestEntity request;

  const AdoptionRequestCancelled(this.request);

  @override
  List<Object?> get props => [request];
}

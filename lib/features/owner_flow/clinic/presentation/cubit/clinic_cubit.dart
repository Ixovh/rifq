import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared_auth/helpers/auth_helper.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/clinic/domain/usecases/clinic_use_case.dart';

part 'clinic_state.dart';

@injectable
class ClinicCubit extends Cubit<ClinicState> {
  final ClinicUseCase useCase;

  ClinicCubit(this.useCase) : super(ClinicInitial());

  //!!---------MAIN LOAD------
  Future<void> loadClinicScreen() async {
    emit(ClinicLoading());

    final isGuest = await AuthHelper.isGuestUser();

    if (isGuest) {
      emit(ClinicGuestState());
      return;
    }

    // ---------- get current logged-in user ID ----------
    final ownerId = await AuthHelper.getUserId();

    if (ownerId == null) {
      emit(ClinicError("Unable to determine user ID"));
      return;
    }

    // ---------- fetch pets ----------
    final petsResult = await useCase.getUserPets(ownerId);

    // ---------- fetch clinics ----------
    final clinicsResult = await useCase.getClinics();

    if (petsResult.isError()) {
      emit(ClinicError(petsResult.tryGetError()!));
      return;
    }

    if (clinicsResult.isError()) {
      emit(ClinicError(clinicsResult.tryGetError()!));
      return;
    }

    final pets = petsResult.tryGetSuccess()!;
    final clinics = clinicsResult.tryGetSuccess()!;

    emit(ClinicScreenLoaded(pets: pets, clinics: clinics));
  }

  // //!!---------Get Clinics type = 1 ------

  // Future<void> getClinics() async {
  //   final result = await useCase.getClinics();

  //   result.when(
  //     (clinics) => emit(ClinicsLoaded(clinics)),
  //     (error) => emit(ClinicError(error)),
  //   );
  // }

  //!!-------------SEARCH CLINIC----------------
  Future<void> searchClinics(String query) async {
    emit(ClinicLoading());

    final result = await useCase.searchClinics(query);

    result.when(
      (clinics) => emit(ClinicScreenLoaded(pets: const [], clinics: clinics)),
      (error) => emit(ClinicError(error)),
    );
  }

  //!!------------GET CLINIC DETAILS-----------
  // Future<void> getClinicDetails(String providerId) async {
  //   emit(ClinicLoading());

  //   final result = await useCase.getClinicDetails(providerId);

  //   result.when(
  //     (details) => emit(ClinicDetailsLoaded(details)),
  //     (error) => emit(ClinicError(error)),
  //   );
  // }
}

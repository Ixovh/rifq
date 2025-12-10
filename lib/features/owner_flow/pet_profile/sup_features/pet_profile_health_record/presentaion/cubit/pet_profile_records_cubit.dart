import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/health_record_entity.dart';
import '../../domain/entity/pet_profile_records_entity.dart';
import '../../domain/entity/reservation_entity.dart';
import '../../domain/usecase/health_record_usecase.dart';

part 'pet_profile_records_state.dart';

class PetProfileRecordsCubit extends Cubit<PetProfileRecordsState> {
  final HealthRecordUsecase usecase;

  PetProfileRecordsCubit(this.usecase) : super(PetProfileRecordsInitial());

// تحميل السجل الصحي و المواعيد
  Future<void> loadPetData(PetEntity pet) async {
    emit(PetProfileLoading());
    try {
      final recordsResult = await usecase.getRecordsByPet(pet.petId);
      final reservationsResult = await usecase.getReservationsByPet(pet.petId);

      recordsResult.when((records) {
        print("reccc${records.length}");
          reservationsResult.when(
                (reservations) {
                  print("reservations${reservations.length}");
                  emit(PetProfileLoaded(
                petent: pet,
                healthRecords: records,
                reservations: reservations,
              ));
            }, (err) => emit(PetProfileError(massege: err)),
          );
        }, (err) => emit(PetProfileError(massege: err)),
      );
    } catch (e) {
      emit(PetProfileError(massege: e.toString()));
    }
  }

  //
 //
 //

// اضافة سجل صحي للحيوان
  Future<void> addHealthRecord(HealthRecordEntity record) async {
    final currentState = state;
    if (currentState is! PetProfileLoaded) return;

    emit(AddingHealthRecord());

    final result = await usecase.addHealthRecord(record);

    result.when(
          (_) {
        final updatedRecords = List<HealthRecordEntity>.from(currentState.healthRecords)
          ..add(record);

        emit(PetProfileLoaded(
          petent: currentState.petent,
          healthRecords: updatedRecords,
          reservations: currentState.reservations,
        ));
      },
          (err) {
        emit(HealthRecordAddError(masseg: "Failed to add record: $err"));
        emit(currentState);
      },
    );
  }

//   Future<void> addHealthRecord(HealthRecordEntity record) async {
//     emit(AddingHealthRecord());
//
//     final result = await usecase.addHealthRecord(record);
//
//     result.when(
//           (_) {
//         emit(HealthRecordAddedSuccess());
//         final currentState = state;
//         if (currentState is PetProfileLoaded) {
//           loadPetData(currentState.petent);
//         }
//         }, (err) {
//         emit(HealthRecordAddError(masseg: "Failed to add record: $err"));
//       },
//     );
//   }


}

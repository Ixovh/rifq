import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq/features/services_provider_flow/home/domain/usecases/reservation_usecase.dart';

part 'visit_details_state.dart';

@injectable
class VisitDetailsCubit extends Cubit<VisitDetailsState> {
  final ReservationUseCase reservationUseCase;
  final TextEditingController treatmentController = TextEditingController();

  VisitDetailsCubit(this.reservationUseCase) : super(VisitDetailsInitial());

  Future<void> sendTreatment(String reservationId) async {
    if (treatmentController.text.trim().isEmpty) {
      emit(VisitDetailsSendError('Please enter treatment and recommendations'));
      return;
    }

    emit(VisitDetailsSending());

    final result = await reservationUseCase.updateReservationTreatment(
      reservationId,
      treatmentController.text.trim(),
    );

    result.when(
      (success) {
        emit(VisitDetailsSendSuccess());
      },
      (error) {
        emit(VisitDetailsSendError(error));
      },
    );
  }

  @override
  Future<void> close() {
    treatmentController.dispose();
    return super.close();
  }
}

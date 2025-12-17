import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/booking_details/domain/use_cases/booking_details_usecase.dart';

part 'booking_details_state.dart';

@injectable
class BookingDetailsCubit extends Cubit<BookingDetailsState> {
  final BookingDetailsUseCase useCase;

  BookingDetailsCubit(this.useCase)
      : super(BookingDetailsInitial());

  Future<void> confirmBooking(ReservationOptEntity booking) async {
    emit(BookingDetailsLoading());

    final result = await useCase.createBooking(booking); //!!!

    result.when(
      (success) => emit(BookingDetailsSuccess(success)),
      (error) => emit(BookingDetailsError(error)),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rifq/core/utils/Exception/custom_exception.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/provider_reservation_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/usecases/reservation_usecase.dart';

part 'home_state.dart';

class ProviderHomeCubit extends Cubit<HomeState> {
  final ReservationUseCase reservationUseCase;

  ProviderHomeCubit(this.reservationUseCase) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());

    // Get provider ID
    final providerIdResult = await reservationUseCase.getProviderIdByAuthId();

    final providerId = providerIdResult.when((success) => success, (error) {
      emit(
        HomeError(error is CustomException ? error.message : error.toString()),
      );
      return null;
    });

    if (providerId == null) {
      return;
    }

    // Get service type
    final serviceTypeResult = await reservationUseCase.getProviderServiceType(
      providerId,
    );

    int? serviceTypeId;
    bool hasError = false;
    serviceTypeResult.when((success) => serviceTypeId = success, (error) {
      emit(
        HomeError(error is CustomException ? error.message : error.toString()),
      );
      hasError = true;
    });

    if (hasError) {
      return;
    }

    // Get reservations
    final reservationsResult = await reservationUseCase.getAllReservations(
      providerId,
    );

    reservationsResult.when(
      (success) {
        emit(
          HomeLoaded(
            serviceTypeId: serviceTypeId,
            reservations: success,
            providerId: providerId,
          ),
        );
      },
      (error) {
        emit(
          HomeError(
            error is CustomException ? error.message : error.toString(),
          ),
        );
      },
    );
  }

  Future<void> acceptReservation(String reservationId) async {
    final currentState = state;
    if (currentState is! HomeLoaded) return;

    emit(
      ReservationActionLoading(
        serviceTypeId: currentState.serviceTypeId,
        reservations: currentState.reservations,
        providerId: currentState.providerId,
      ),
    );

    final result = await reservationUseCase.acceptReservation(reservationId);
    result.when(
      (success) {
        // Reload reservations after accepting
        loadHomeData();
      },
      (error) {
        emit(
          HomeError(
            error is CustomException ? error.message : error.toString(),
          ),
        );
      },
    );
  }

  Future<void> rejectReservation(String reservationId) async {
    final currentState = state;
    if (currentState is! HomeLoaded) return;

    emit(
      ReservationActionLoading(
        serviceTypeId: currentState.serviceTypeId,
        reservations: currentState.reservations,
        providerId: currentState.providerId,
      ),
    );

    final result = await reservationUseCase.rejectReservation(reservationId);
    result.when(
      (success) {
        // Reload reservations after rejecting
        loadHomeData();
      },
      (error) {
        emit(
          HomeError(
            error is CustomException ? error.message : error.toString(),
          ),
        );
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/clinic_details/domain/usecases/get_clinic_details_usecase.dart';

part 'clinic_details_state.dart';

@injectable
class ClinicDetailsCubit extends Cubit<ClinicDetailsState> {
  final ClinicDetailsUseCase usecase;

  ClinicDetailsCubit(this.usecase) : super(ClinicDetailsLoading());

  Future<void> load(String providerId) async {
    emit(ClinicDetailsLoading());

    final result = await usecase(providerId);

    result.when(
      (entity) => emit(ClinicDetailsLoaded(entity)),
      (error) => emit(ClinicDetailsError(error)),
    );
  }
}


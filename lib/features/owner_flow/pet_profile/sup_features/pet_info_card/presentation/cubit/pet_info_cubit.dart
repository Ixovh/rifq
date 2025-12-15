import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../domain/entity/pet_entity.dart';
import '../../domain/usecase/pet_profile_usecase.dart';

part 'pet_info_state.dart';

@injectable
class PetInfoCubit extends Cubit<PetInfoState> {
  final PetProfileUsecase usecase;

  PetInfoCubit(this.usecase) : super(PetInfoInitial());


  void getPets(String ownerId) async {
    emit(PetLoading());
    final result = await usecase.getPetsByOwner(ownerId);
    result.when(
          (pets) => emit(PetLoaded(pets)), // success
          (err)  => emit(PetError(err)),   // error
    );

  }
}

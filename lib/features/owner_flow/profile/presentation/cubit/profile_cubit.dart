import 'package:bloc/bloc.dart';

import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/user_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserProfileUsecase usecase;

  ProfileCubit(this.usecase) : super(ProfileInitial());

  Future<void> getUserProfile(String authId) async {
    emit(ProfileLoading());
    final result = await usecase.getUserProfile(authId);
    result.when(
          (success) {
            print("ProfileCubit");

            emit(ProfileLoaded(success));
          },
          (error) {
            print(error.toString());

            emit(ProfileError(error));
          },
    );
  }

  Future<void> updateUserProfile(UserProfileEntity user) async {
    emit(ProfileLoading());

    final result = await usecase.updateUserProfile(user);

    result.when(
          (success) => emit(ProfileUpdated(success)),
          (error) => emit(ProfileError(error)),
    );
  }
}
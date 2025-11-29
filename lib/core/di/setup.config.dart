// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/owner_flow/add_pet/data/datasources/add_pet_data_source.dart'
    as _i1071;
import '../../features/owner_flow/add_pet/data/repositories/add_pet_repo_data.dart'
    as _i891;
import '../../features/owner_flow/add_pet/domain/repositories/add_pet_repo_domain.dart'
    as _i585;
import '../../features/owner_flow/add_pet/domain/usecases/add_pet_use_case.dart'
    as _i22;
import '../../features/owner_flow/add_pet/presentation/cubit/add_pet_cubit.dart'
    as _i763;
import '../../features/owner_flow/auth/data/datasources/auth_data_source.dart'
    as _i386;
import '../../features/owner_flow/auth/data/repositories/auth_repo_data.dart'
    as _i64;
import '../../features/owner_flow/auth/domain/repositories/auth_repo_domain.dart'
    as _i693;
import '../../features/owner_flow/auth/domain/usecases/auth_use_case.dart'
    as _i1001;
import '../../features/owner_flow/pet_profile/data/datasources/pet_profile_datasources.dart'
    as _i694;
import '../../features/owner_flow/pet_profile/domain/repositories/health_record_repository.dart'
    as _i253;
import '../../features/owner_flow/pet_profile/domain/repositories/reservation_repository.dart'
    as _i219;
import '../../features/owner_flow/pet_profile/domain/usecases/health_record_usecase.dart'
    as _i901;
import '../../features/owner_flow/pet_profile/domain/usecases/reservation_usecase.dart'
    as _i116;
import '../../features/owner_flow/pet_profile/sup_features/pet_info_card/data/datasources/pet_card_info_datasources.dart'
    as _i918;
import '../../features/owner_flow/pet_profile/sup_features/pet_info_card/data/repositories/pet_card_info_repo_data.dart'
    as _i384;
import '../../features/owner_flow/pet_profile/sup_features/pet_info_card/domain/repositories/pet_profile_repo_domain.dart'
    as _i557;
import '../../features/owner_flow/pet_profile/sup_features/pet_info_card/domain/usecase/pet_profile_usecase.dart'
    as _i479;
import '../../features/owner_flow/pet_profile/sup_features/reservation_appointment/domain/repositories/reservation_repository.dart'
    as _i968;
import '../../features/owner_flow/pet_profile/sup_features/reservation_appointment/domain/usecases/reservation_usecase.dart'
    as _i485;
import '../../features/owner_flow/profile/data/datasources/user_profile_datasources.dart'
    as _i972;
import '../../features/owner_flow/profile/data/repositories/repo_data.dart'
    as _i332;
import '../../features/owner_flow/profile/domain/repositories/repo_domain.dart'
    as _i754;
import '../../features/owner_flow/profile/domain/usecases/user_profile_usecase.dart'
    as _i591;
import 'third_party_module.dart' as _i811;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    gh.singleton<_i792.GetStorage>(() => thirdPartyModule.storage);
    gh.singleton<_i454.SupabaseClient>(() => thirdPartyModule.supabaseClient);
    gh.lazySingleton<_i694.PetProfileDataSource>(
      () => _i694.PetProfileDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i918.PatCard>(
      () => _i918.PetCardInfoDatasources(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i891.HealthRecordUsecase>(
      () => _i891.HealthRecordUsecase(gh<_i231.HealthRecordRepositoryDomain>()),
    );
    gh.lazySingleton<_i972.BaseUserProfileDataSourc>(
      () => _i972.DataBaseDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i1071.BaseAddPetDataSource>(
      () => _i1071.AddPetDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i116.ReservationUsecase>(
      () => _i116.ReservationUsecase(gh<_i219.ReservationRepository>()),
    );
    gh.lazySingleton<_i754.RepoDomain>(
      () => _i332.RepoData(gh<_i972.BaseUserProfileDataSourc>()),
    );
    gh.lazySingleton<_i386.BaseAuthDataSource>(
      () => _i386.SubaBaseDataSource(
        supabase: gh<_i454.SupabaseClient>(),
        box: gh<_i792.GetStorage>(),
      ),
    );
    gh.lazySingleton<_i557.PetProfileRepoDomain>(
      () => _i384.RepoDataPet(gh<_i918.PatCard>()),
    );
    gh.lazySingleton<_i585.AddPetRepoDomain>(
      () => _i891.AddPetRepoData(gh<_i1071.BaseAddPetDataSource>()),
    );
    gh.lazySingleton<_i591.UserProfileUsecase>(
      () => _i591.UserProfileUsecase(userProfileData: gh<_i754.RepoDomain>()),
    );
    gh.factory<_i22.AddPetUseCase>(
      () => _i22.AddPetUseCase(gh<_i585.AddPetRepoDomain>()),
    );
    gh.lazySingleton<_i479.PetProfileUsecase>(
      () => _i479.PetProfileUsecase(gh<_i557.PetProfileRepoDomain>()),
    );
    gh.lazySingleton<_i693.AuthRepoDomain>(
      () => _i64.AuthRepoData(authDataSource: gh<_i386.BaseAuthDataSource>()),
    );
    gh.factory<_i1001.AuthUseCase>(
      () => _i1001.AuthUseCase(authRepoData: gh<_i693.AuthRepoDomain>()),
    );
    gh.factory<_i763.AddPetCubit>(
      () => _i763.AddPetCubit(gh<_i22.AddPetUseCase>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i811.ThirdPartyModule {}

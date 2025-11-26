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

import '../../features/owner_flow/pet_profile/data/datasources/pet_profile_datasources.dart'
    as _i694;
import '../../features/owner_flow/pet_profile/domain/repositories/health_record_repository.dart'
    as _i253;
import '../../features/owner_flow/pet_profile/domain/repositories/pet_profile_repo_domain.dart'
    as _i59;
import '../../features/owner_flow/pet_profile/domain/repositories/reservation_repository.dart'
    as _i219;
import '../../features/owner_flow/pet_profile/domain/usecases/health_record_usecase.dart'
    as _i901;
import '../../features/owner_flow/pet_profile/domain/usecases/pet_profile_usecase.dart'
    as _i821;
import '../../features/owner_flow/pet_profile/domain/usecases/reservation_usecase.dart'
    as _i116;
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
    gh.factory<_i694.DataBaseDataSource>(() => _i694.DataBaseDataSource());
    gh.singleton<_i792.GetStorage>(() => thirdPartyModule.storage);
    gh.singleton<_i454.SupabaseClient>(() => thirdPartyModule.supabaseClient);
    gh.lazySingleton<_i901.HealthRecordUsecase>(
      () => _i901.HealthRecordUsecase(gh<_i253.HealthRecordRepositoryDomain>()),
    );
    gh.lazySingleton<_i972.BaseUserProfileDataSourc>(
      () => _i972.DataBaseDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i116.ReservationUsecase>(
      () => _i116.ReservationUsecase(gh<_i219.ReservationRepository>()),
    );
    gh.lazySingleton<_i821.PetProfileUsecase>(
      () => _i821.PetProfileUsecase(gh<_i59.PetProfileRepoDomain>()),
    );
    gh.lazySingleton<_i754.RepoDomain>(
      () => _i332.RepoData(gh<_i972.BaseUserProfileDataSourc>()),
    );
    gh.lazySingleton<_i591.UserProfileUsecase>(
      () => _i591.UserProfileUsecase(userProfileData: gh<_i754.RepoDomain>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i811.ThirdPartyModule {}

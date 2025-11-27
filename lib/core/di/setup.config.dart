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
    gh.lazySingleton<_i1071.BaseAddPetDataSource>(
      () => _i1071.AddPetDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i585.AddPetRepoDomain>(
      () => _i891.AddPetRepoData(gh<_i1071.BaseAddPetDataSource>()),
    );
    gh.factory<_i22.AddPetUseCase>(
      () => _i22.AddPetUseCase(gh<_i585.AddPetRepoDomain>()),
    );
    gh.factory<_i763.AddPetCubit>(
      () => _i763.AddPetCubit(gh<_i22.AddPetUseCase>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i811.ThirdPartyModule {}

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

import '../../features/owner_flow/auth/data/datasources/auth_data_source.dart'
    as _i386;
import '../../features/owner_flow/auth/data/repositories/auth_repo_data.dart'
    as _i64;
import '../../features/owner_flow/auth/domain/repositories/auth_repo_domain.dart'
    as _i693;
import '../../features/owner_flow/auth/domain/usecases/auth_use_case.dart'
    as _i1001;
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
    gh.lazySingleton<_i386.BaseAuthDataSource>(
      () => _i386.SubaBaseDataSource(
        supabase: gh<_i454.SupabaseClient>(),
        box: gh<_i792.GetStorage>(),
      ),
    );
    gh.lazySingleton<_i693.AuthRepoDomain>(
      () => _i64.AuthRepoData(authDataSource: gh<_i386.BaseAuthDataSource>()),
    );
    gh.factory<_i1001.AuthUseCase>(
      () => _i1001.AuthUseCase(authRepoData: gh<_i693.AuthRepoDomain>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i811.ThirdPartyModule {}

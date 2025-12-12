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
import '../../features/owner_flow/adoption/data/datasources/adoption_data_source.dart'
    as _i1014;
import '../../features/owner_flow/adoption/data/repositories/adoption_repo_data.dart'
    as _i320;
import '../../features/owner_flow/adoption/domain/repositories/adoption_repo_domain.dart'
    as _i979;
import '../../features/owner_flow/adoption/domain/usecases/adotion_use_case.dart'
    as _i796;
import '../../features/owner_flow/auth/data/datasources/auth_data_source.dart'
    as _i386;
import '../../features/owner_flow/auth/data/repositories/auth_repo_data.dart'
    as _i64;
import '../../features/owner_flow/auth/domain/repositories/auth_repo_domain.dart'
    as _i693;
import '../../features/owner_flow/auth/domain/usecases/auth_use_case.dart'
    as _i1001;
import '../../features/owner_flow/clinic/data/datasources/clinic_data_source.dart'
    as _i814;
import '../../features/owner_flow/clinic/data/repositories/clinic_repo_data.dart'
    as _i359;
import '../../features/owner_flow/clinic/domain/repositories/clinic_repo_domain.dart'
    as _i324;
import '../../features/owner_flow/clinic/domain/usecases/clinic_use_case.dart'
    as _i143;
import '../../features/owner_flow/clinic/presentation/cubit/clinic_cubit.dart'
    as _i250;
import '../../features/owner_flow/home/data/datasources/home_data_source.dart'
    as _i695;
import '../../features/owner_flow/home/data/repositories/home_repo_data.dart'
    as _i663;
import '../../features/owner_flow/home/domain/repositories/home_repo_domain.dart'
    as _i981;
import '../../features/owner_flow/home/domain/use_cases/home_use_case.dart'
    as _i322;
import '../../features/owner_flow/home/presentation/cubit/home_cubit.dart'
    as _i743;
import '../../features/owner_flow/hotel/data/datasource/hotel_datasource.dart'
    as _i49;
import '../../features/owner_flow/hotel/data/repository/hotel_repo_data.dart'
    as _i60;
import '../../features/owner_flow/hotel/domain/repository/hotel_repo_domain.dart'
    as _i390;
import '../../features/owner_flow/hotel/domain/usecase/hotel_usecase.dart'
    as _i4;
import '../../features/owner_flow/hotel/sup_feauter/booking_hotel/data/datasource/booking_hotel_datasource.dart'
    as _i771;
import '../../features/owner_flow/hotel/sup_feauter/booking_hotel/data/repository/booking_hotel_repo_data.dart'
    as _i797;
import '../../features/owner_flow/hotel/sup_feauter/booking_hotel/domain/repository/booking_hotel_repo_domain.dart'
    as _i104;
import '../../features/owner_flow/hotel/sup_feauter/booking_hotel/domain/usecase/booking_hotel_usecase.dart'
    as _i189;
import '../../features/owner_flow/hotel/sup_feauter/payment/data/datasource/payment_datasource.dart'
    as _i18;
import '../../features/owner_flow/hotel/sup_feauter/payment/data/repository/repo_data.dart'
    as _i843;
import '../../features/owner_flow/hotel/sup_feauter/payment/domain/repository/repo_domain.dart'
    as _i835;
import '../../features/owner_flow/hotel/sup_feauter/payment/domain/usecase/payment_usecase.dart'
    as _i616;
import '../../features/owner_flow/pet_profile/sup_features/edit_pet_profile/data/datasources/edit_pet_profile_datasources.dart'
    as _i131;
import '../../features/owner_flow/pet_profile/sup_features/edit_pet_profile/data/repositories/edit_pet_profile_repo.dart'
    as _i737;
import '../../features/owner_flow/pet_profile/sup_features/edit_pet_profile/domain/repositories/edit_pet_profile_repo_domain.dart'
    as _i650;
import '../../features/owner_flow/pet_profile/sup_features/edit_pet_profile/domain/usecase/edit_pet_profile_usecase.dart'
    as _i961;
import '../../features/owner_flow/pet_profile/sup_features/pet_info_card/data/datasources/pet_card_info_datasources.dart'
    as _i918;
import '../../features/owner_flow/pet_profile/sup_features/pet_info_card/data/repositories/pet_card_info_repo_data.dart'
    as _i384;
import '../../features/owner_flow/pet_profile/sup_features/pet_info_card/domain/repositories/pet_profile_repo_domain.dart'
    as _i557;
import '../../features/owner_flow/pet_profile/sup_features/pet_info_card/domain/usecase/pet_profile_usecase.dart'
    as _i479;
import '../../features/owner_flow/pet_profile/sup_features/pet_profile_health_record/data/datasourse/pet_prifile_record_data.dart'
    as _i595;
import '../../features/owner_flow/pet_profile/sup_features/pet_profile_health_record/data/repository/pet_profile_records_repo_data.dart'
    as _i618;
import '../../features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/repositories/pet_profile_records_repo.dart'
    as _i809;
import '../../features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/usecase/health_record_usecase.dart'
    as _i319;
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
    gh.lazySingleton<_i131.BaseEditPetProfile>(
      () => _i131.EditPetProfileDatasources(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i918.PatCard>(
      () => _i918.PetCardInfoDatasources(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i972.BaseUserProfileDataSourc>(
      () => _i972.DataBaseDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i18.BaseDtaSourcePayment>(
      () => _i18.PaymentDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i771.BaseBookingHotelDataSource>(
      () => _i771.BookingHotelDatasource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i1071.BaseAddPetDataSource>(
      () => _i1071.AddPetDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i104.BookingHotelRepoDomain>(
      () => _i797.BookingHotelRepoData(gh<_i771.BaseBookingHotelDataSource>()),
    );
    gh.lazySingleton<_i595.BaseDataSourcePetReacord>(
      () => _i595.PetPrifileRecordDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i49.BaseHotelDataSourc>(
      () => _i49.HotelDataBase(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i1014.AdoptionDataSource>(
      () => _i1014.AdoptionDataBaseSoruce(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i695.BaseHomeDataSource>(
      () => _i695.HomeDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i814.BaseClinicDataSource>(
      () => _i814.ClinicDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i324.ClinicRepoDomain>(
      () => _i359.ClinicRepoData(gh<_i814.BaseClinicDataSource>()),
    );
    gh.lazySingleton<_i835.PaymentRepoDomain>(
      () => _i843.PaymentRepoData(gh<_i18.BaseDtaSourcePayment>()),
    );
    gh.lazySingleton<_i189.BookingHotelUsecase>(
      () => _i189.BookingHotelUsecase(gh<_i104.BookingHotelRepoDomain>()),
    );
    gh.lazySingleton<_i754.RepoDomain>(
      () => _i332.RepoData(gh<_i972.BaseUserProfileDataSourc>()),
    );
    gh.lazySingleton<_i979.AdoptionRepoDomain>(
      () => _i320.AdoptionRepoData(gh<_i1014.AdoptionDataSource>()),
    );
    gh.lazySingleton<_i386.BaseAuthDataSource>(
      () => _i386.SubaBaseDataSource(
        supabase: gh<_i454.SupabaseClient>(),
        box: gh<_i792.GetStorage>(),
      ),
    );
    gh.lazySingleton<_i796.AdoptionUseCase>(
      () => _i796.AdoptionUseCase(gh<_i979.AdoptionRepoDomain>()),
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
    gh.lazySingleton<_i390.HotelRepoDomain>(
      () => _i60.HotelRepoData(gh<_i49.BaseHotelDataSourc>()),
    );
    gh.lazySingleton<_i4.HotelUsecase>(
      () => _i4.HotelUsecase(gh<_i390.HotelRepoDomain>()),
    );
    gh.lazySingleton<_i650.EditPetProfileRepoDomain>(
      () => _i737.EditPetProfileRepo(gh<_i131.BaseEditPetProfile>()),
    );
    gh.lazySingleton<_i981.HomeRepoDomain>(
      () => _i663.HomeRepoImpl(gh<_i695.BaseHomeDataSource>()),
    );
    gh.lazySingleton<_i616.PaymentUsecase>(
      () => _i616.PaymentUsecase(gh<_i835.PaymentRepoDomain>()),
    );
    gh.lazySingleton<_i809.PetProfileRecordsRepo>(
      () =>
          _i618.PetProfileRecordsRepoData(gh<_i595.BaseDataSourcePetReacord>()),
    );
    gh.factory<_i22.AddPetUseCase>(
      () => _i22.AddPetUseCase(gh<_i585.AddPetRepoDomain>()),
    );
    gh.factory<_i143.ClinicUseCase>(
      () => _i143.ClinicUseCase(gh<_i324.ClinicRepoDomain>()),
    );
    gh.lazySingleton<_i479.PetProfileUsecase>(
      () => _i479.PetProfileUsecase(gh<_i557.PetProfileRepoDomain>()),
    );
    gh.lazySingleton<_i319.HealthRecordUsecase>(
      () => _i319.HealthRecordUsecase(gh<_i809.PetProfileRecordsRepo>()),
    );
    gh.lazySingleton<_i961.EditPetProfileUsecase>(
      () => _i961.EditPetProfileUsecase(gh<_i650.EditPetProfileRepoDomain>()),
    );
    gh.factory<_i322.GetHomeDataUseCase>(
      () => _i322.GetHomeDataUseCase(gh<_i981.HomeRepoDomain>()),
    );
    gh.lazySingleton<_i693.AuthRepoDomain>(
      () => _i64.AuthRepoData(authDataSource: gh<_i386.BaseAuthDataSource>()),
    );
    gh.factory<_i250.ClinicCubit>(
      () => _i250.ClinicCubit(gh<_i143.ClinicUseCase>()),
    );
    gh.lazySingleton<_i1001.AuthUseCase>(
      () => _i1001.AuthUseCase(authRepoData: gh<_i693.AuthRepoDomain>()),
    );
    gh.factory<_i763.AddPetCubit>(
      () => _i763.AddPetCubit(gh<_i22.AddPetUseCase>()),
    );
    gh.factory<_i743.HomeCubit>(
      () => _i743.HomeCubit(gh<_i322.GetHomeDataUseCase>()),
    );
    return this;
  }
}

class _$ThirdPartyModule extends _i811.ThirdPartyModule {}

import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/clinic/data/datasources/clinic_data_source.dart';
import 'package:rifq/features/owner_flow/clinic/domain/repositories/clinic_repo_domain.dart';

@LazySingleton(as: ClinicRepoDomain)
class ClinicRepoData implements ClinicRepoDomain {
  final BaseClinicDataSource dataSource;

  ClinicRepoData(this.dataSource);


  @override
  Future<Result<List<ProviderEntity>, String>> getClinics() async {
    final result = await dataSource.getClinics();

    return result.when(
      (success) => Result.success(
        success.map((m) => m as ProviderEntity).toList(),
      ),
      (error) => Result.error(error),
    );
  }


  @override
  Future<Result<List<ProviderEntity>, String>> searchClinics(String query) async {
    final result = await dataSource.searchClinics(query);

    return result.when(
      (success) => Result.success(
        success.map((m) => m as ProviderEntity).toList(),
      ),
      (error) => Result.error(error),
    );
  }

    @override
  Future<Result<List<PetModel>, String>> getUserPets(String ownerId) async {
    try {
      final response = await dataSource.fetchUserPets(ownerId);
      final pets = response
          .map((row) => PetModelMapper.fromMap(row))
          .toList();
      return Success(pets);
    } catch (e) {
      return Error(e.toString());
    }
  }
}

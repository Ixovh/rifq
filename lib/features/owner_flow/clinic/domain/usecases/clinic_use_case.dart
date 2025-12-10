import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';
import 'package:rifq/features/owner_flow/clinic/domain/repositories/clinic_repo_domain.dart';



@injectable
class ClinicUseCase {
  final ClinicRepoDomain repository;

  ClinicUseCase(this.repository);

  Future<Result<List<ProviderEntity>, String>> getClinics() {
    return repository.getClinics();
  }

  Future<Result<List<ProviderEntity>, String>> searchClinics(String query) {
    return repository.searchClinics(query);
  }

  Future<Result<List<ProviderItemsViewEntity>, String>> getClinicDetails(String providerId) {
    return repository.getClinicDetails(providerId);
  }

  Future<Result<List<PetModel>, String>> getUserPets(String ownerId) {
    return repository.getUserPets(ownerId);
  }
}

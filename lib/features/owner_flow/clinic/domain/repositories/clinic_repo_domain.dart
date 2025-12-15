
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import 'package:rifq/features/owner_flow/add_pet/data/models/pet_model.dart';


abstract class ClinicRepoDomain {

  Future<Result<List<ProviderEntity>, String>> getClinics();

  Future<Result<List<ProviderEntity>, String>> searchClinics(String query);

  // Future<Result<List<ProviderItemsViewEntity>, String>> getClinicDetails(String providerId);

   Future<Result<List<PetModel>, String>> getUserPets(String ownerId);
}
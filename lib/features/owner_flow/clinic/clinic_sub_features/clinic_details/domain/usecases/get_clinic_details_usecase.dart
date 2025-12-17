import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/clinic_details/domain/repositories/clinic_details_repo_domain.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';

@injectable
class ClinicDetailsUseCase {
  final ClinicDetailsRepoDomain repo;

  ClinicDetailsUseCase(this.repo);

  Future<Result<ProviderItemsViewEntity, String>> call(String providerId) {
    return repo.getClinicDetails(providerId);
  }
}

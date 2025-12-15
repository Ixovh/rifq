import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/clinic_details/data/datasources/clinic_details_data_source.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/clinic_details/domain/repositories/clinic_details_repo_domain.dart';

@LazySingleton(as: ClinicDetailsRepoDomain)
class ClinicDetailsRepoData implements ClinicDetailsRepoDomain {
  final BaseClinicDetailsDataSource dataSource;

  ClinicDetailsRepoData(this.dataSource);

  @override
  Future<Result<ProviderItemsViewEntity, String>> getClinicDetails(String providerId) async {
    try {
      final model = await dataSource.getClinicDetails(providerId);
      return Success(model);
    } catch (e) {
      return Error(e.toString());
    }
  }
}

import 'package:injectable/injectable.dart';
import 'package:rifq/features/owner_flow/home/domain/entity/home_data_entity.dart';
import 'package:rifq/features/owner_flow/home/domain/repositories/home_repo_domain.dart';

import 'package:multiple_result/multiple_result.dart';

@injectable
class GetHomeDataUseCase {
  final HomeRepoDomain repo;

  GetHomeDataUseCase(this.repo);

  Future<Result<HomeDataEntity, String>> getHomeData() async {
    return await repo.getHomeData();
  }
}

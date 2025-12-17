import 'package:multiple_result/multiple_result.dart';
import 'package:rifq/features/owner_flow/home/domain/entity/home_data_entity.dart';

abstract class HomeRepoDomain {

  Future<Result<HomeDataEntity, String>> getHomeData();
}

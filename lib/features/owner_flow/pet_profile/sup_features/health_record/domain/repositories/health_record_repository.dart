import 'package:multiple_result/multiple_result.dart';
import '../entity/health_record_entity.dart';


abstract class HealthRecordRepositoryDomain {
  Future<List<HealthRecordEntity>> getRecordsByPet(String petId);

}
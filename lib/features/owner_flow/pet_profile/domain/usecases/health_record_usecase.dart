import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../entity/health_record_entity.dart';
import '../repositories/health_record_repository.dart';

@lazySingleton
class HealthRecordUsecase {
  final HealthRecordRepositoryDomain repository;

  HealthRecordUsecase(this.repository);

  Future<Result<List<HealthRecordEntity>, String>> getRecordsByPet(String petId) async {
    try {
      final records = await repository.getRecordsByPet(petId);
      return Result.success(records);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
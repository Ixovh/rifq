
import 'package:injectable/injectable.dart';
import 'package:rifq/features/owner_flow/ai/data/datasources/ai_message_datasource.dart';
import 'package:rifq/features/owner_flow/ai/domain/entity/ai_message_entity.dart';
import 'package:rifq/features/owner_flow/ai/domain/repositories/ai_message_repo_domain.dart';

@LazySingleton(as: AiRepoDomain)
class AIRepoData implements AiRepoDomain {
  final AIDatasource _remoteDatasource;

  AIRepoData(this._remoteDatasource);
  @override
  AIEntity aiCongif() {
    return _remoteDatasource.aiCongif(); 
  }

}

// import 'package:injectable/injectable.dart';
// import 'package:rifq/features/owner_flow/ai/data/datasources/ai_message_datasource.dart';
// import 'package:rifq/features/owner_flow/ai/domain/repositories/ai_message_repo_domain.dart';

// @LazySingleton(as: AiMessageRepoDomain)
// class AiMessageRepoData implements AiMessageRepoDomain {
//   final BaseAiMessageDataSource dataSource;

//   AiMessageRepoData({required this.dataSource});


//   @override
//   Future<String> sendText(String message) {
//     return dataSource.sendText(message);
//   }

//   @override
//   Future<String> sendImage(String message, List<int> imageBytes) {
//     return dataSource.sendImage(message, imageBytes);
//   }

// }
// //!!!!!

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
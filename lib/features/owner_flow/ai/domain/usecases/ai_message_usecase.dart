// import 'package:injectable/injectable.dart';
// import 'package:rifq/features/owner_flow/ai/domain/repositories/ai_message_repo_domain.dart';

// @injectable
// class AiMessageUseCase {
//   final AiMessageRepoDomain repository;

//   AiMessageUseCase(this.repository);

//   Future<String> sendText(String message) {
//     return repository.sendText(message);
//   }

//   Future<String> sendImage(String message, List<int> imageBytes) {
//     return repository.sendImage(message, imageBytes);
//   }
// }
// ///!!!!

import 'package:injectable/injectable.dart';
import 'package:rifq/features/owner_flow/ai/domain/entity/ai_message_entity.dart';
import 'package:rifq/features/owner_flow/ai/domain/repositories/ai_message_repo_domain.dart';

@lazySingleton
class AIConfigUsecase {
  final AiRepoDomain _repository;

  AIConfigUsecase(this._repository);

  AIEntity call() {
    return _repository.aiCongif();
  }
}
// abstract class AiMessageRepoDomain {
//   Future<String> sendText(String message);
//   Future<String> sendImage(String message, List<int> imageBytes);
// }
// ///!!!!

import 'package:rifq/features/owner_flow/ai/domain/entity/ai_message_entity.dart';

abstract class AiRepoDomain {
  AIEntity aiCongif();
}
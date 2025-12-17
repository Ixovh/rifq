import '../../../../../../../core/shared/enum/status_payment_enum.dart';

class PaymentEntity {
  final String id;
  final String userId;
  final String context;
  final String contextId;
  final num amount;
  final StatusPaymentEnum status;
  final DateTime createdAt;

  PaymentEntity({
    required this.id,
    required this.userId,
    required this.context,
    required this.contextId,
    required this.amount,
    required this.status,
    required this.createdAt
});

}
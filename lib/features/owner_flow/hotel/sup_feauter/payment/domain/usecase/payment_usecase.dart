import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../../../../core/shared/enum/status_payment_enum.dart';
import '../entity/payment_entity.dart';
import '../repository/repo_domain.dart';

@lazySingleton
class PaymentUsecase {
  final PaymentRepoDomain payDomain;

  PaymentUsecase(this.payDomain);

  /// إضافة دفعة جديدة
  Future<Result<void, String>> addPayment(PaymentEntity payment) async {
    try {
      await payDomain.addPayment(payment);
      return Result.success(null);
    } catch (e) {
      return Result.error("Failed to add payment: $e");
    }
  }

  Future<Result<PaymentEntity?, String>> getPaymentById(String paymentId) async {
    try {
      final result = await payDomain.getPaymentById(paymentId);
      return result.when(
            (payment) {
          if (payment == null) {
            return Result.error("Payment not found!");
          } else {
            return Success(payment);
          }
        }, (message) {
          return Result.error("Failed to fetch payment: $message");
        },
      );} catch (e) {
      return Result.error("Unexpected error: $e");
    }
  }


  /// تحديث حالة الدفع
  Future<Result<void, String>> updatePaymentStatus(String paymentId, StatusPaymentEnum status) async {
    try {
      await payDomain.updatePaymentStatus(paymentId, status);
      return Result.success(null);
    } catch (e) {
      return Result.error("Failed to update payment status: $e");
    }
  }
}

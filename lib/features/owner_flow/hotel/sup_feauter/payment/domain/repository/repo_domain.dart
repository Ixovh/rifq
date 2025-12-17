import 'package:multiple_result/multiple_result.dart';

import '../../../../../../../core/shared/enum/status_payment_enum.dart';
import '../entity/payment_entity.dart';

abstract class PaymentRepoDomain {
  // اضافة الدفع
  Future<Result<void, String>> addPayment(PaymentEntity payment);
  // نجيب دفعه معينه
  Future<Result<PaymentEntity?, String>> getPaymentById(String paymentId);
  // تحديث الحاله بعد الدفع نجاح ,رفض ..الح
  Future<Result<void, String>> updatePaymentStatus(String paymentId, StatusPaymentEnum status);
}


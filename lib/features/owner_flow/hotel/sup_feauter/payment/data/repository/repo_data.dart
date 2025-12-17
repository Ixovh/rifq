import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../domain/entity/payment_entity.dart';
import '../../domain/repository/repo_domain.dart';
import '../datasource/payment_datasource.dart';
import '../../../../../../../core/shared/enum/status_payment_enum.dart';

@LazySingleton(as: PaymentRepoDomain)
class PaymentRepoData implements PaymentRepoDomain {
  final BaseDtaSourcePayment datasource;

  PaymentRepoData(this.datasource);

  @override
  Future<Result<void, String>> addPayment(PaymentEntity payment) async {
    return await datasource.addPayment(payment);
  }

  @override
  Future<Result<PaymentEntity?, String>> getPaymentById(String paymentId) async {
    return await datasource.getPaymentById(paymentId);
  }

  @override
  Future<Result<void, String>> updatePaymentStatus(String paymentId, StatusPaymentEnum status) async {
    return await datasource.updatePaymentStatus(paymentId, status);
  }
}

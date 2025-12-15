import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/shared/enum/status_payment_enum.dart';
import '../../domain/entity/payment_entity.dart';

abstract class BaseDtaSourcePayment{
  Future<Result<void, String>> addPayment(PaymentEntity payment);
  // نجيب دفعه معينه
  Future<Result<PaymentEntity?, String>> getPaymentById(String paymentId);
  // تحديث الحاله بعد الدفع نجاح ,رفض ..الح
  Future<Result<void, String>> updatePaymentStatus(String paymentId, StatusPaymentEnum status);
}

@LazySingleton(as:BaseDtaSourcePayment)
class PaymentDatasource  implements BaseDtaSourcePayment{
  final SupabaseClient supabase;

  PaymentDatasource(this.supabase);


  @override
  Future<Result<void, String>> addPayment(PaymentEntity payment) async {
    try {
      final response = await supabase.from('payments').insert({
        'id': payment.id,
        'user_id': payment.userId,
        'context': payment.context,
        'context_id': payment.contextId,
        'amount': payment.amount,
        'status': payment.status.name,
        'created_at': payment.createdAt.toIso8601String(),
      });
      print(response.error);
      print(response.data);
      return Success(null);
    } catch (e) {
      return Error("Unexpected error: $e");
    }
  }




  @override
  Future<Result<PaymentEntity?, String>> getPaymentById(String paymentId) async {
    try {
      final data = await supabase
          .from('payments')
          .select()
          .eq('id', paymentId)
          .maybeSingle();
      if (data == null) return Error("Payment not found!");
      final payment = PaymentEntity(
        id: data['id'],
        userId: data['user_id'],
        context: data['context'],
        contextId: data['context_id'],
        amount: data['amount'],
        status: StatusPaymentEnum.values.firstWhere((e) => e.name == data['status']),
        createdAt: DateTime.parse(data['created_at']),
      );

      return Success(payment);
    } catch (e) {
      return Error("Unexpected error: $e");
    }
  }

  ///
  ///


  @override
  Future<Result<void, String>> updatePaymentStatus(String paymentId, StatusPaymentEnum status) async {
    try {
      await supabase
          .from('payments')
          .update({'status': status.name})
          .eq('id', paymentId);

      return Success(null);
    } catch (e) {
      return Error("Unexpected error: $e");
    }
  }


  // @override
  // Future<Result<void, String>> addPayment(PaymentEntity payment)async {
  //   print("Inserting status: '${payment.status.name}'");
  //   final response = await supabase.from('payments').insert({
  //     'id': payment.id,
  //     'user_id': payment.userId,
  //     'context': payment.context,
  //     'context_id': payment.contextId,
  //     'amount': payment.amount,
  //     'status': payment.status.name.toLowerCase(),
  //     'created_at': payment.createdAt.toIso8601String(),
  //   });
  //
  //   if (response.error != null) {
  //     return Error("Supabase insert error: ${response.error!.message}");
  //   } else {
  //     return Success(null);
  //   }
  //
  //
  // }

}
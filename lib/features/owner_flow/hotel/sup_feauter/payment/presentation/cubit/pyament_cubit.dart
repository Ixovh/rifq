import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../../core/shared/enum/status_payment_enum.dart';
import '../../domain/entity/payment_entity.dart';
import '../../domain/usecase/payment_usecase.dart';

part 'pyament_state.dart';

class PyamentCubit extends Cubit<PyamentState> {
  final PaymentUsecase paymentUsecase;
  PyamentCubit(this.paymentUsecase) : super(PaymentInitial());



  Future<void> savePayment({
    required String paymentId,
    required String userId,
    required int amount,
    required String bookingId,
    required StatusPaymentEnum status,
  }) async {
    emit(PaymentLoading());

    try {
      final paymentEntity = PaymentEntity(
        id: paymentId,
        userId: userId,
        context: 'booking',
        contextId: bookingId,
        amount: amount / 100, // من هللات لريالات
        status: status,
        createdAt: DateTime.now(),
      );

      final result = await paymentUsecase.addPayment(paymentEntity);
      result.when(
            (success) {
          print("Payment inserted successfully");
          emit(PaymentSuccess()); },
            (error) {
          print("Error inserting payment: $error");
          emit(PaymentError(message: error.toString()));
        },
      );

      // result.when(
      //       (success) => emit(PaymentSuccess()),
      //       (error) => emit(PaymentError(message: error.toString())),
      // );
    } catch (e) {
      emit(PaymentError( message: 'Unexpected error: $e'));
    }
  }
}

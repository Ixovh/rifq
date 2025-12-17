import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moyasar/moyasar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/di/setup.dart';
import '../../../../../../../core/routes/base_routes.dart';
import '../../../../../../../core/shared/enum/status_payment_enum.dart';
import '../../../../../../../core/common/widgets/lottie_loading/lottie_loding.dart';
import '../../domain/usecase/payment_usecase.dart';
import '../cubit/pyament_cubit.dart';

class PaymentScreen extends StatelessWidget {
  final int amount;
  final String bookingId;

  const PaymentScreen({
    super.key,
    required this.amount,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PyamentCubit(getIt<PaymentUsecase>()),
      child: _PaymentScreenContent(amount: amount, bookingId: bookingId),
    );
  }
}

class _PaymentScreenContent extends StatelessWidget {
  final int amount;
  final String bookingId;

  const _PaymentScreenContent({required this.amount, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final paymentConfig = PaymentConfig(
      publishableApiKey: 'pk_test_KvY16gPmp6n5YxxyUmL61GPBbwUF3qxDUbErCyBE',
      amount: amount,
      description: 'order #$bookingId',
      metadata: {'bookingId': bookingId},
    );
    return BlocListener<PyamentCubit, PyamentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          context.push(Routes.successfullpay);
        } else if (state is PaymentError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<PyamentCubit, PyamentState>(
          builder: (context, state) {
            if (state is PaymentLoading) {
              return LottieLoding();
            }
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: CreditCard(
                      config: paymentConfig,
                      onPaymentResult: (result) =>
                          _onPaymentResult(context, result),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onPaymentResult(BuildContext context, result) {
    if (result is PaymentResponse) {
      final status = result.status == PaymentStatus.paid
          ? StatusPaymentEnum.paid
          : StatusPaymentEnum.failed;
      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('User not authenticated')));
        return;
      }
      context.read<PyamentCubit>().savePayment(
        paymentId: result.id, // معرف الدفعة من ميسر
        userId: userId,
        amount: amount,
        bookingId: bookingId,
        status: status,
      );
    }
  }
}

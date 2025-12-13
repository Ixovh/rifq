// import 'package:flutter/material.dart';
// import 'package:moyasar/moyasar.dart';
//
// class PaymentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final paymentConfig = PaymentConfig(
//       publishableApiKey: 'YOUR_API_KEY',
//       amount: 25758, // SAR 257.58
//       description: 'order #1324',
//       metadata: {'size': '250g'},
//       applePay: ApplePayConfig(merchantId: 'YOUR_MERCHANT_ID', label: 'YOUR_STORE_NAME'),
//       // givenID: Uuid().v4(), // Optional. The payment ID to be created from your side to apply Idempotency (UUID -- v4 is recommended).
//     );
//     void onPaymentResult(result) {
//       if (result is PaymentResponse) {
//         switch (result.status) {
//           case PaymentStatus.paid:
//           // handle success.
//             break;
//           case PaymentStatus.failed:
//           // handle failure.
//             break;
//         }
//       }
//     }
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//             children: [
//               Text("data")
//             ],
//           )),
//
//     );
//   }
// }

// هنا صصصصصصصصصصصصصح بدون كيوبت
//
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:moyasar/moyasar.dart';
//
// import '../../../../../../../core/routes/base_routes.dart';
//
// class PaymentScreen extends StatelessWidget {
//   final int amount;
//   final String bookingId;
//   const PaymentScreen({
//     super.key,
//     required this.amount,
//     required this.bookingId,
//   });  @override
//   Widget build(BuildContext context) {
//     // استلام البيانات من الصفحة السابقة
//     final paymentConfig = PaymentConfig(
//       publishableApiKey: 'pk_test_KvY16gPmp6n5YxxyUmL61GPBbwUF3qxDUbErCyBE',
//       amount: amount,
//       description: 'order #$bookingId',
//       metadata: {'bookingId': bookingId},
//     );
//
//     void onPaymentResult(result) {
//       if (result is PaymentResponse) {
//         switch (result.status) {
//           case PaymentStatus.paid:
//             context.push(Routes.successfullpay);
//             break;
//             default:
//         // case PaymentStatus.failed:
//             break;
//         }
//       }
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(onPressed: (){
//           context.pop();
//         }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
//       ),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.0),
//           child: Center(
//             child: SingleChildScrollView(
//             child: CreditCard(
//                   config: paymentConfig,
//                   onPaymentResult: onPaymentResult,
//                 ),
//
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moyasar/moyasar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/di/setup.dart';
import '../../../../../../../core/routes/base_routes.dart';
import '../../../../../../../core/shared/enum/status_payment_enum.dart';
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
    create: (context) => PyamentCubit(
      getIt<PaymentUsecase>(),
    ),
      child: _PaymentScreenContent(amount: amount, bookingId: bookingId),
    );
  }
}

class _PaymentScreenContent extends StatelessWidget {
  final int amount;
  final String bookingId;

  const _PaymentScreenContent({
    required this.amount,
    required this.bookingId,
  });

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
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
              return Center(child: CircularProgressIndicator());
            }
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: CreditCard(
                      config: paymentConfig,
                      onPaymentResult: (result) => _onPaymentResult(context, result),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not authenticated')),
        );
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
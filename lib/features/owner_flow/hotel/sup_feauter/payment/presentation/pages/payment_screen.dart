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


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moyasar/moyasar.dart';

import '../../../../../../../core/routes/base_routes.dart';

class PaymentScreen extends StatelessWidget {
  final int amount;
  final String bookingId;
  const PaymentScreen({
    super.key,
    required this.amount,
    required this.bookingId,
  });  @override
  Widget build(BuildContext context) {
    // استلام البيانات من الصفحة السابقة


    final paymentConfig = PaymentConfig(
      publishableApiKey: 'pk_test_KvY16gPmp6n5YxxyUmL61GPBbwUF3qxDUbErCyBE',
      amount: amount,
      description: 'order #$bookingId',
      metadata: {'bookingId': bookingId},
    );

    void onPaymentResult(result) {
      if (result is PaymentResponse) {
        switch (result.status) {
          case PaymentStatus.paid:
            context.push(Routes.successfullpay);
            break;
            default:
        // case PaymentStatus.failed:
            break;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          context.pop();
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: SingleChildScrollView(
            child: CreditCard(
                  config: paymentConfig,
                  onPaymentResult: onPaymentResult,
                ),
          
            ),
          ),
        ),
      ),
    );
  }
}

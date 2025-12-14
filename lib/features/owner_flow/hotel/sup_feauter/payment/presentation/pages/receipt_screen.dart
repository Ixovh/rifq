// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
// import '../../../../../../../core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
// import '../../../../../../../core/shared/enum/status_payment_enum.dart';
// import '../../domain/entity/payment_entity.dart';
// import '../widgets/recipet_widgets.dart';
//
// class ReceiptScreen extends StatelessWidget {
//   final ReservationOptEntity booking;
//   final ProviderItemsViewEntity hotel;
//   final PaymentEntity payment;
//
//   const ReceiptScreen({
//     super.key,
//     required this.booking,
//     required this.hotel,
//     required this.payment,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final paymentStatus = payment.status == StatusPaymentEnum.paid;
//     final nights = booking.endDate!.difference(booking.startDate).inDays;
//     final totalPrice = nights * (hotel.price ?? 0);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Receipt"),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: ConfirmedPaymentWidget(
//           booking: booking,
//           hotel: hotel,
//           payment: payment,
//
//         ),
//       ),
//     );
//   }
// }

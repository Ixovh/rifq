// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../../../core/shared/enum/status_payment_enum.dart';
// import '../../../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
// import '../../../../../../../core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
// import '../../domain/entity/payment_entity.dart';
//
// class ConfirmedPaymentWidget extends StatelessWidget {
//   final ReservationOptEntity booking;
//   final ProviderItemsViewEntity hotel;
//   final PaymentEntity payment;
//
//   const ConfirmedPaymentWidget({
//     super.key,
//     required this.booking,
//     required this.hotel,
//     required this.payment,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final dateFormat = DateFormat('dd MMM yyyy');
//     final checkInFormatted = dateFormat.format(booking.startDate);
//     final checkOutFormatted = dateFormat.format(booking.endDate!);
//     final paymentStatus = payment.status == StatusPaymentEnum.paid;
//     final totalPrice = (booking.endDate!.difference(booking.startDate).inDays) *
//         (hotel.price ?? 0);
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Container(
//           padding: EdgeInsets.all(16.w),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16.r),
//             border: Border.all(color: const Color(0xFFDEE1E8)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // صورة واسم الفندق
//               Row(
//                 children: [
//                   if (hotel.providerImage != null && hotel.providerImage!.isNotEmpty)
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image.network(
//                         hotel.providerImage!,
//                         height: 90.h,
//                         width: 87.w,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   SizedBox(width: 16.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           hotel.providerName,
//                           style: TextStyle(
//                               fontSize: 16.sp, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           hotel.location ?? '',
//                           style: TextStyle(
//                               fontSize: 14.sp, color: Colors.grey[600]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: 20.h),
//               Text('Booking Date', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
//               Text('Check-in: $checkInFormatted'),
//               Text('Check-out: $checkOutFormatted'),
//
//               SizedBox(height: 20.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Payment Status', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                     decoration: BoxDecoration(
//                       color: paymentStatus ? Colors.green : Colors.red,
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                     child: Text(paymentStatus ? 'Paid' : 'Not Paid',
//                         style: TextStyle(color: Colors.white)),
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: 20.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Total Price', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//                   Text('$totalPrice', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

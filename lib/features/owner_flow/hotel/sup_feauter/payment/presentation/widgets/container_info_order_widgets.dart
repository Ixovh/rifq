import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_color.dart';

import '../../../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import '../../../../../../../core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';

class ContainerInfoOrderWidgets extends StatelessWidget {
  final ReservationOptEntity booking;
  final ProviderItemsViewEntity hotel;
  final List<String> selectedPets;
  final double total;

  const ContainerInfoOrderWidgets({
    super.key,
    required this.booking,
    required this.hotel,
    required this.selectedPets,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final checkInFormatted = dateFormat.format(booking.startDate);
    final checkOutFormatted = booking.endDate != null
        ? dateFormat.format(booking.endDate!)
        :'No selected';
    final numberofPets = selectedPets.length;

    return Container(
      padding: EdgeInsets.all(16),
      width: 355.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFDEE1E8),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (hotel.providerImage != null && hotel.providerImage!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    hotel.providerImage!,
                    height: 90.h,
                    width: 87.w,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(width: 17.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel.providerName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ), SizedBox(height: 4.h),
                    Text(
                      hotel.location ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          Text("Your Order", style: TextStyle(fontSize: 16.sp,color: AppColors.neutral1000,fontWeight: FontWeight.w500)),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Services Selected",style: TextStyle(color: Color(0xFF828898),fontSize: 14.sp,fontWeight: FontWeight.w400),),
              Text(hotel.itemName),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Number of Pets",style: TextStyle(color: Color(0xFF828898),fontSize: 14.sp,fontWeight: FontWeight.w400)),
              Text('$numberofPets'),
            ],
          ),

          SizedBox(height: 17.h),
          DottedLine(dashColor: Color(0xFFDEE1E8)),

          SizedBox(height: 17.h),
          Text("Booking Date",style: TextStyle(fontSize: 16.sp,color: AppColors.neutral1000,fontWeight: FontWeight.w500)),
          SizedBox(height: 17.h),
          Text("Check-in: $checkInFormatted"),
          SizedBox(height: 8.h),
          Text("Check-out: $checkOutFormatted"),

          SizedBox(height: 17.h),
          DottedLine(dashColor: Color(0xFFDEE1E8)),

          SizedBox(height: 17.h),
          Text("Price Details",style: TextStyle(fontSize: 16.sp,color: AppColors.neutral1000,fontWeight: FontWeight.w500)),
          SizedBox(height: 8.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Room Price"),
              Text('${hotel.price}'),
            ],
          ),

          SizedBox(height: 12.h),
          DottedLine(dashColor: Color(0xFFDEE1E8)),
          SizedBox(height: 17.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Price", style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$total', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          )

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_color.dart';

import '../../data/model/hotel_model.dart';

class RoomsTabContent extends StatelessWidget {
  final HotelModel hotel;

  const RoomsTabContent({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            Text(hotel.itemName),
            SizedBox(width: 16.w),
            Container(
              width: 133.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.neutral400,
              ),
              child: Text("SAR ${hotel.price}/night"),
    )

    ],
    // child: Text(hotel.itemName),
    )

      ],
    );
  }
}

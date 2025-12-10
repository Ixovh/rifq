import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardHotel extends StatelessWidget {
  final String imageHotel;
  final String nameHotle;
  final String location;
  // final String price;
  // final String services;
  final VoidCallback? onTap;

  const CardHotel({
    super.key,
    this.onTap,
     required this.imageHotel,
    required this.nameHotle,
    required this.location,
    // required this.price,
    // required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0.r),
                    child: Image.network(
                      imageHotel,
                      width: 105.w,
                      height: 107.h,
                      fit: BoxFit.cover,
                    ),
                  ), SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameHotle,
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 14),
                            SizedBox(width: 4.w),
                            Text(location, style: TextStyle(fontSize: 12.sp)),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        // Row(
                        //   children: [
                        //     Icon(Icons.attach_money, size: 14),
                        //     SizedBox(width: 4.w),
                        //     Text(price, style: TextStyle(fontSize: 12.sp)),
                        //   ],
                        // ),
                        SizedBox(height: 4.h),
                        // Text(
                        //   'Services : $services',
                        //   style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 12.h),
              // Text(
              //   'Services : $services',
              //   style: TextStyle(fontSize: 13.sp, color: Colors.black87),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


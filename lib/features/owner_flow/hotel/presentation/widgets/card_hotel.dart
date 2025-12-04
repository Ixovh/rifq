// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CardHotel extends StatelessWidget {
//   final String imageHotel;
//   final String nameHotle;
//   final String location;
//   final String price;
//   final String services;
//   const CardHotel({super.key,
//     required this.imageHotel,
//     required this.nameHotle,
//     required this.location,
//     required this.price,
//     required this.services});
//   @override
//   Widget build(BuildContext context) {
//    return Card(
//      child: Column(
//        children: [
//          Row(
//            children: [
//              Image.asset(imageHotel),
//              SizedBox(width: 12.w),
//              Text(nameHotle),
//              SizedBox(width: 12.w),
//              Text(location),
//              SizedBox(width: 12.w),
//              Text(price),
//              SizedBox(width: 12.w),
//              Text(services),
//            ],
//          )
//        ],
//      ),
//    );
//   }
// }
//
//


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardHotel extends StatelessWidget {
  final String imageHotel;
  final String nameHotle;
  final String location;
  final String price;
  final String services;

  const CardHotel({
    super.key,
    required this.imageHotel,
    required this.nameHotle,
    required this.location,
    required this.price,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: Image.asset(
                    imageHotel,
                    width: 100.w,
                    height: 100.h,
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
                      Row(
                        children: [
                          Icon(Icons.attach_money, size: 14),
                          SizedBox(width: 4.w),
                          Text(price, style: TextStyle(fontSize: 12.sp)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Services : $services',
              style: TextStyle(fontSize: 13.sp, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
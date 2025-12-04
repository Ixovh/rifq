// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:rifq/core/theme/app_theme.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../widgets/card_hotel.dart';
//
// class HotelHomeScreen  extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  AppBar(
//         leading: CircleAvatar(),
//         title:  Text("Hotel",
//           style: context.body1.copyWith(color: context.primary300)),
//         centerTitle: true,
//         actions: [
//           GestureDetector(
//             onTap: (){},
//             child: Image.asset("assets/images/notification-bing.png"),
//           )
//           // IconButton(onPressed: (){},
//           //     icon: Icon(Icons.notifications,color:Colors.white,))
//         ],
//       ),
//
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(padding: EdgeInsets.symmetric(horizontal: 16.h,vertical: 10),
//               child: TextField(
//                 onChanged: (value){
//                   //كيوبت
//                 },
//                 decoration: InputDecoration(
//                   hintText: "Search here...",
//                   prefixIcon: Icon(Icons.search),
//                   filled: true,
//                   contentPadding: EdgeInsets.symmetric(vertical: 12.h),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                     borderSide: BorderSide.none
//                   )
//                 ),
//               ),
//             ),
//             CardHotel(
//               imageHotel: 'assets/images/logo (1).png',
//               nameHotle: 'The Pets Hotel',
//               location: 'Riyadh',
//               price: 'start 50',
//               services: 'Boarding / Daycare / VIP Room',),
//             SizedBox(height: 11.h),
//             CardHotel(
//               imageHotel: 'assets/images/logo (1).png',
//               nameHotle: 'The Pets Hotel',
//               location: 'Riyadh',
//               price: 'start 50',
//               services: 'Boarding / Daycare / VIP Room',),
//             SizedBox(height: 11.h),
//             CardHotel(
//               imageHotel: 'assets/images/logo (1).png',
//               nameHotle: 'The Pets Hotel',
//               location: 'Riyadh',
//               price: 'start 50',
//               services: 'Boarding / Daycare / VIP Room',),
//             SizedBox(height: 11.h),
//             CardHotel(
//               imageHotel: 'assets/images/logo (1).png',
//               nameHotle: 'The Pets Hotel',
//               location: 'Riyadh',
//               price: 'start 50',
//               services: 'Boarding / Daycare / VIP Room',),
//             SizedBox(height: 11.h),
//             CardHotel(
//               imageHotel: 'assets/images/logo (1).png',
//               nameHotle: 'The Pets Hotel',
//               location: 'Riyadh',
//               price: 'start 50',
//               services: 'Boarding / Daycare / VIP Room',), SizedBox(height: 11.h),
//             CardHotel(
//               imageHotel: 'assets/images/logo (1).png',
//               nameHotle: 'The Pets Hotel',
//               location: 'Riyadh',
//               price: 'start 50',
//               services: 'Boarding / Daycare / VIP Room',),
//
//
//           ],
//         ),
//       ),
//
//  );
//   }
//
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/common/widgets/appbar/custom_app_bar.dart';
import 'package:rifq/core/theme/app_theme.dart';

import '../widgets/card_hotel.dart';

class HotelHomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> dummyHotels = [
    {
      "image": "assets/images/logo (1).png",
      "name": "The Pets Hotel",
      "location": "Riyadh",
      "price": "start 50",
      "services": "Boarding / Daycare / VIP Room",
    },
    {
      "image": "assets/images/logo (1).png",
      "name": "Cat Heaven Resort",
      "location": "Riyadh",
      "price": "start 80",
      "services": "VIP Room / Grooming",
    },
    {
      "image": "assets/images/logo (1).png",
      "name": "Pet Paradise",
      "location": "Riyadh",
      "price": "start 60",
      "services": "Boarding / Play Area",
    },
    {
      "image": "assets/images/logo (1).png",
      "name": "Pet Paradise",
      "location": "Riyadh",
      "price": "start 60",
      "services": "Boarding / Play Area",
    },
    {
      "image": "assets/images/logo (1).png",
      "name": "Pet Paradise",
      "location": "Riyadh",
      "price": "start 60",
      "services": "Boarding / Play Area",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Hotel"),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   scrolledUnderElevation: 0,
      //   leading: CircleAvatar(),
      //   title: Text("Hotel", style: context.body1.copyWith(color: context.primary300),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     GestureDetector(
      //       onTap: () {},
      //       // child: Image.asset("assets/images/notification-bing.png"),
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10),
            child: TextField(
              onChanged: (value) {
                //  كيوبت
              },
              decoration: InputDecoration(
                hintText: "Search here...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Color(0xFFECECEC), width: 1.w),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: dummyHotels.length,
              separatorBuilder: (context, index) => SizedBox(height: 11.h),
              itemBuilder: (context, index) {
                final hotel = dummyHotels[index];

                return CardHotel(
                  imageHotel: hotel["image"],
                  nameHotle: hotel["name"],
                  location: hotel["location"],
                  price: hotel["price"],
                  services: hotel["services"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

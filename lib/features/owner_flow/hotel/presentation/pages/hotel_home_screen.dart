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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/di/setup.dart';
import 'package:rifq/core/theme/app_theme.dart';
import '../../../../../core/routes/base_routes.dart';
import '../../domain/usecase/hotel_usecase.dart';
import '../cubit/hotel_cubit.dart';
import '../widgets/card_hotel.dart';


class HotelHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelCubit(getIt<HotelUsecase>())..fetchAllHotels(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          leading: CircleAvatar(),
          title: Text(
            "Hotel", style: context.body1.copyWith(color: context.primary300),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {},
              child: Image.asset("assets/images/notification-bing.png"),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10),
              child: TextField(
                onChanged: (value) {
                  context.read<HotelCubit>().fetchAllHotels();
                },
                decoration: InputDecoration(
                  hintText: "Search here...",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Color(0xFFECECEC),
                      width: 1.w,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<HotelCubit, HotelState>(
                builder: (context, state) {
                  if (state is HotelLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HotelLoaded) {
                    final hotels = state.hotels; // البيانات من Cubit
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: hotels.length,
                      separatorBuilder: (context, index) => SizedBox(height: 11.h),
                      itemBuilder: (context, index) {
                        final hotel = hotels[index]; // نوعه ProviderServiceViewEntity / HotelModel
                        return CardHotel(
                          imageHotel: hotel.image!,
                          nameHotle: hotel.name,
                          location: hotel.location,
                          // price: "start ${hotel.price}",       // السعر
                          // services: hotel.itemName, // الخدمات
                          // onTap: (){
                          //   context.push(Routes.detailsHotel,extra: hotel);
                          // },
                          onTap: () {
                            final cubit =context.read<HotelCubit>();
                            cubit.fetchHotelById(hotel.id.toString());
                            context.push(Routes.detailsHotel, extra: {
                              'hotel': hotel,
                              'cubit':cubit ,
                            });
                          },

                        );
                      },
                    );
                  } else if (state is HotelError) {
                    return Center(child: Text(state.message));
                  }

                  return SizedBox();
                },
              ),
            )


            // Expanded(
            //   child: BlocBuilder<HotelCubit, HotelState>(
            //     builder: (context, state) {
            //       if(state is HotelLoading){
            //         return Center(child:  CircularProgressIndicator(),);
            //       }
            //       if(state is HotelLoaded){
            //
            //       }
            //       return ListView.separated(
            //         padding: EdgeInsets.symmetric(horizontal: 16.w),
            //         itemCount: dummyHotels.length,
            //         separatorBuilder: (context, index) =>
            //             SizedBox(height: 11.h),
            //         itemBuilder: (context, index) {
            //           final hotel = dummyHotels[index];
            //
            //           return CardHotel(
            //             imageHotel: hotel["image"],
            //             nameHotle: hotel["name"],
            //             location: hotel["location"],
            //             price: hotel["price"],
            //             services: hotel["services"],
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
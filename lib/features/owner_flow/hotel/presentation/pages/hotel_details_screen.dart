import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/theme/app_theme.dart';
import '../../data/model/hotel_model.dart';
import '../widgets/hotel_image_carousel.dart';
import '../widgets/hotel_info.dart';
import '../widgets/room_content.dart';
import '../widgets/tab_bar.dart';

class HotelDetailsScreen extends StatelessWidget {
  final HotelModel hotel;
  const HotelDetailsScreen({super.key, required this.hotel, });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                context.pop();
                },
              icon: Icon(Icons.arrow_back_ios)),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HotelImagesCarousel(images: [hotel.image]),
                    SizedBox(height: 6.h),
                    Padding(
                      padding: EdgeInsets.all(6),
                        child: Text(hotel.providerName,style: context.h5,)),
                    Padding(
                      padding: const EdgeInsets.all(7),
                      child: Row(
                        children: [
                          Image.asset("assets/images/Frame 1984077898.png"),
                          SizedBox(width: 5.w),
                          Text(hotel.location,style: context.body2.copyWith(color: context.neutral600),)
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

            CustomTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  RoomsTabContent(hotel: hotel,),
                  HotelInfoTabContent(hotel: hotel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

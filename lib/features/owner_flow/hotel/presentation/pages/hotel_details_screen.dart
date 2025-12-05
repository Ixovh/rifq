import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';
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
                    Text(hotel.providerName),
                    SizedBox(height: 6.h),
                    Text(hotel.location),
                    SizedBox(height: 10.h),
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

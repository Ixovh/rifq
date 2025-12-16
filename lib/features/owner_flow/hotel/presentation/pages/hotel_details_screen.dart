import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/features/owner_flow/hotel/presentation/cubit/hotel_cubit.dart';
import 'package:rifq/features/owner_flow/hotel/presentation/widgets/hotel_info.dart' show HotelInfoTabContent;
import 'package:rifq/features/owner_flow/hotel/presentation/widgets/room_content.dart';
import 'package:rifq/features/owner_flow/hotel/presentation/widgets/tab_bar.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import '../../../../../core/theme/app_theme.dart';
import '../widgets/hotel_image_carousel.dart';


class HotelDetailsScreen extends StatelessWidget {
  final ProviderEntity hotel;
  const HotelDetailsScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is HotelError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red),
                  SizedBox(height: 16),
                  Text(state.message),
                ],
              ),
            );}
          if (state is HotelDetailLoaded) {
            final hotelItems=state.hotelItems;
            final hotelDetails=hotelItems.first;
            return DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HotelImagesCarousel(
                              images: [hotelDetails.providerImage ?? '']),
                          SizedBox(height: 6.h),
                          Padding(
                            padding: EdgeInsets.all(6),
                            child: Text(
                              hotelDetails.providerName,
                              style: context.h5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Row(
                              children: [
                                Image.asset(
                                    "assets/images/Frame 1984077898.png"
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  hotelDetails.location ?? '',
                                  style: context.body2.copyWith(
                                      color: context.neutral600
                                  ),
                                )
                              ],),),
                        ],
                      ),),),
                  CustomTabBar(),
                  Expanded(
                    child: TabBarView(
                      children: [
                        RoomsTabContent(hotelItems: hotelItems,),
                        HotelInfoTabContent(hotel: hotelDetails),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
              child: CircularProgressIndicator());
        },
      ),
    );
  }
}

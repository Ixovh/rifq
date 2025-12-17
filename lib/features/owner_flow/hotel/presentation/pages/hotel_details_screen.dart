import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/common/widgets/lottie_loading/lottie_loding.dart';
import 'package:rifq/features/owner_flow/hotel/presentation/cubit/hotel_cubit.dart';
import 'package:rifq/features/owner_flow/hotel/presentation/widgets/hotel_info.dart'
    show HotelInfoTabContent;
import 'package:rifq/features/owner_flow/hotel/presentation/widgets/room_content.dart';
import 'package:rifq/features/owner_flow/hotel/presentation/widgets/tab_bar.dart';
import 'package:url_launcher/url_launcher.dart';
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
      body: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading) {
            return LottieLoding();
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
            );
          }
          if (state is HotelDetailLoaded) {
            final hotelItems = state.hotelItems;
            final hotelDetails = hotelItems.first;
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
                          // HotelImagesCarousel(
                          //   images: [hotelDetails.providerImage ?? ''],
                          // ),
                          Stack(
                            children: [
                              Image.network(
                                hotelDetails.providerImage ?? "",
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 40,
                                left: 16,
                                child: GestureDetector(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: 0.5,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 6.h),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  hotelDetails.providerName,
                                  style: context.h5,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                               SizedBox(width: 10,),
                              Icon(
                                  Icons.location_on,
                                  size: 22,
                                  color: context.red100,
                                ),
                                SizedBox(width: 10,),
                              Expanded(
                                child: Text(
                                  hotelDetails.location ?? '',
                                  style: context.body1.copyWith(
                                    color: context.neutral600,
                                  ),
                                ),
                              ),
                               InkWell(
                                  onTap: () => _call(hotelDetails.phone),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 18,
                                        color: context.primary500,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        hotelDetails.phone!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          // decoration: TextDecoration.underline,
                                        ),
                                      ),
                                       SizedBox(width: 15,),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomTabBar(),
                  Expanded(
                    child: TabBarView(
                      children: [
                        RoomsTabContent(hotelItems: hotelItems),
                        HotelInfoTabContent(hotel: hotelDetails),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return LottieLoding();
        },
      ),
    );
  }
    void _call(String? phone) async {
    if (phone == null) return;
    final uri = Uri(scheme: 'tel', path: phone);
    await launchUrl(uri);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/di/setup.dart';
import '../../../../../core/common/widgets/appbar/custom_app_bar.dart';
import '../../../../../core/common/widgets/lottie_loading/lottie_loding.dart';
import '../../../../../core/routes/base_routes.dart';
import '../../domain/usecase/hotel_usecase.dart';
import '../cubit/hotel_cubit.dart';
import '../widgets/card_hotel.dart';
import '../widgets/hotel_search_bar.dart';


class HotelHomeScreen extends StatelessWidget {
  const HotelHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelCubit(getIt<HotelUsecase>())..fetchAllHotels(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:CustomAppBar(title: 'Hotel',),
        body: Column(
          children: [
            HotelSearchBar(),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 10),
            //   child: TextField(
            //     onChanged: (value) {
            //       context.read<HotelCubit>().fetchAllHotels();
            //     },
            //     decoration: InputDecoration(
            //       hintText: "Search here...",
            //       prefixIcon: Icon(Icons.search),
            //       filled: true,
            //       fillColor: Colors.white,
            //       contentPadding: EdgeInsets.symmetric(vertical: 12.h),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12.r),
            //         borderSide: BorderSide(
            //           color: Color(0xFFECECEC),
            //           width: 1.w,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: BlocBuilder<HotelCubit, HotelState>(
                builder: (context, state) {
                  if (state is HotelLoading) {
                    return Center(child: LottieLoding());
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
                          location: hotel.location!,
                          phone: hotel.phone!,
                          onTap: () {
                            context.push(
                              Routes.detailsHotel,
                              extra: hotel, // فقط الفندق
                            );
                          },
                        
                        );
                      },
                    );
                  } else if (state is HotelError) {
                    return Center(child: Text(state.message));
                  }
                  return Center(child: LottieLoding());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
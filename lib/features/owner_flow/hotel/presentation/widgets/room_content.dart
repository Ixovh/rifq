// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:rifq/core/theme/app_color.dart';
// import '../../../../../core/common/widgets/button/custome_button_widgets.dart';
// import '../../../../../core/routes/base_routes.dart';
// import '../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
// import '../cubit/hotel_cubit.dart';
//
// class RoomsTabContent extends StatelessWidget {
//   // final ProviderItemsViewEntity hotel;
//   final List<ProviderItemsViewEntity> hotelItems;
//   const RoomsTabContent({super.key, required this.hotelItems, });
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<HotelCubit>();
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: 1,
//             itemBuilder: (context, index) {
//               final room = hotel;
//               return BlocBuilder<HotelCubit, HotelState>(
//                 builder: (context, state) {
//                   final isSelected = cubit.selectedRoomId == room.itemId;
//                   return GestureDetector(
//                     onTap: () => cubit.selectRoom(room.itemId,room),
//                     child: Container(
//                       margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
//                       padding: EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: isSelected
//                                 ? AppColors.primary300//ااذا كان مختار الخدمة
//                                 : Colors.grey.shade300,
//                             width: isSelected ? 2 : 0,
//                           ),
//                         // borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(room.itemName),
//                           Text("SAR ${room.price}/night"),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           SizedBox(height: 200.h),
//           BlocBuilder<HotelCubit, HotelState>(
//             builder: (context, state) {
//               return CustomeButtonWidgets(
//                 titel: 'Book Now',
//                 onPressed: cubit.selectedRoomId != null
//                     ? () {
//                   context.push(Routes.bookingHotel,
//                     extra: {
//                     'hotel': hotel,
//                     'roomId': cubit.selectedRoomId,
//                   },);
//                   // context.push(Routes.bookingHotel, extra: {
//                   //   'hotel': hotel,
//                   //   'roomId': cubit.selectedRoomId,
//                   // });
//                 } : () {}, //  هنا زر معطل
//                 buttonWidth: 366.w,
//                 buttonhight: 58.h,
//               );
//     },
//     )  ,
//         ],
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/theme/app_color.dart';
import '../../../../../core/common/widgets/button/custome_button_widgets.dart';
import '../../../../../core/routes/base_routes.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import '../cubit/hotel_cubit.dart';

class RoomsTabContent extends StatelessWidget {
  // final ProviderItemsViewEntity hotel;
  final List<ProviderItemsViewEntity>hotelItems;

  const RoomsTabContent({super.key, required this.hotelItems, });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HotelCubit>();
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: hotelItems.length,
            itemBuilder: (context, index) {
              final room = hotelItems[index];
              return BlocBuilder<HotelCubit, HotelState>(
                builder: (context, state) {
                  final isSelected = cubit.selectedRoomId == room.itemId;
                  return GestureDetector(
                    onTap: () => cubit.selectRoom(room.itemId,room),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary300//ااذا كان مختار الخدمة
                              : Colors.grey.shade300,
                          width: isSelected ? 2 : 0,
                        ),
                        // borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(room.itemName),
                          Text("SAR ${room.price}/night"),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: 120.h),
          BlocBuilder<HotelCubit, HotelState>(
            builder: (context, state) {
              return CustomeButtonWidgets(
                titel: 'Book Now',
                onPressed: () {
                  if (cubit.selectedRoomId != null && cubit.selectedRoomDetails != null) {
                    context.push(
                      Routes.bookingHotel,
                      extra: {
                        'hotel': cubit.selectedRoomDetails!,
                        'roomId': cubit.selectedRoomId,
                      },
                    );
                  }
                },
                buttonWidth: 366.w,
                buttonhight: 58.h,
              );
            },
          )
          // BlocBuilder<HotelCubit, HotelState>(
          //   builder: (context, state) {
          //     return CustomeButtonWidgets(
          //       titel: 'Book Now',
          //       onPressed: cubit.selectedRoomId != null
          //           ? () {
          //         context.push(Routes.bookingHotel,
          //           extra: {
          //             'hotel': hotelItems,
          //             'roomId': cubit.selectedRoomId,
          //           },);
          //         // context.push(Routes.bookingHotel, extra: {
          //         //   'hotel': hotel,
          //         //   'roomId': cubit.selectedRoomId,
          //         // });
          //       } : () {}, //  هنا زر معطل
          //       buttonWidth: 366.w,
          //       buttonhight: 58.h,
          //     );
          //   },
          // )  ,
        ],
      ),
    );
  }
}
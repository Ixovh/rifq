// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rifq/core/theme/app_color.dart';
//
// import '../../../../../core/common/widgets/button/custome_button_widgets.dart';
// import '../../data/model/hotel_model.dart';
//
// class RoomsTabContent extends StatelessWidget {
//   final HotelModel hotel;
//
//   const RoomsTabContent({super.key, required this.hotel});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       // crossAxisAlignment: .start,
//       children: [
//         Row(
//           children: [
//             Text(hotel.itemName),
//             SizedBox(width: 16.w),
//             Container(
//               width: 133.w,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: AppColors.neutral400,
//               ),
//               child: Text("SAR ${hotel.price}/night"),
//     ),],
//     ),
//         SizedBox(height: 220.h),
//         CustomeButtonWidgets(
//           titel: 'Book Now',
//           onPressed: () {  },
//           buttonWidth: 366.w,
//           buttonhight: 58.h,)
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/common/widgets/button/custome_button_widgets.dart';
import '../../../../../core/theme/app_color.dart';
import '../../data/model/hotel_model.dart';
import '../cubit/hotel_cubit.dart';

class RoomsTabContent extends StatelessWidget {
  final HotelModel hotel;

  const RoomsTabContent({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HotelCubit>();
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              final room = hotel;
              return BlocBuilder<HotelCubit, HotelState>(
                builder: (context, state) {
                  final isSelected = cubit.selectedRoomId == room.itemId;
                  return GestureDetector(
                    onTap: () => cubit.selectRoom(room.itemId),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.withValues(alpha:0.3) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
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
          SizedBox(height: 200.h),
          BlocBuilder<HotelCubit, HotelState>(
            builder: (context, state) {
              return CustomeButtonWidgets(
                titel: 'Book Now',
                onPressed: cubit.selectedRoomId != null
                    ? () {
                  context.push('/booking', extra: {
                    'hotel': hotel,
                    'roomId': cubit.selectedRoomId,
                  });
                }
                    : () {}, //  هنا زر معطل
                buttonWidth: 366.w,
                buttonhight: 58.h,
              );
            },
          )
        ],
      ),
    );
  }
}

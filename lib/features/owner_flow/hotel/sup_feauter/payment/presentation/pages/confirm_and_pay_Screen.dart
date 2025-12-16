// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';

import '../../../../../../../core/common/widgets/button/custome_button_widgets.dart';
import '../../../../../../../core/routes/base_routes.dart';
import '../widgets/container_info_order_widgets.dart';

class ConfirmAndPayScreen extends StatelessWidget {
  final ReservationOptEntity booking;
  final ProviderItemsViewEntity hotel;
  final List<String> selectedPets;
  const ConfirmAndPayScreen({super.key, required this.booking, required this.hotel, required this.selectedPets});
  @override
  Widget build(BuildContext context) {
    final nights = booking.endDate != null
        ? booking.endDate!.difference(booking.startDate).inDays
        : 0;
    final total = (nights * hotel.price!).toDouble();
    return Scaffold(
    appBar: AppBar(
      title: Text("Confirm and Pay",style: TextStyle(color: Color(0xFF333333),fontSize: 18.sp,fontWeight: FontWeight.w600),),
      centerTitle: true,
      leading: IconButton(
          onPressed: (){
            context.pop();
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,)),
    ),
       body: SingleChildScrollView(
         child: Padding(
           padding: EdgeInsets.all(20),
           child: Column(
             crossAxisAlignment: .center,
               children: [
                 ContainerInfoOrderWidgets(
                   booking: booking,
                   hotel: hotel,
                   selectedPets: selectedPets,
                   total: total,),
                 SizedBox(height: 30.h),
                 CustomeButtonWidgets(
                   titel: 'Confirm and Pay',
                   onPressed: () {
                     context.push(Routes.paymentscreen,extra: {
                       'amount': (total * 100).toInt(),//تحويل المبلغ الى هلله
                       'bookingId':booking.id
                     });
                   },
                   buttonWidth: 366.w,
                   buttonhight: 58.h,)
           ],
              ),
         ),
       ));
  }
}
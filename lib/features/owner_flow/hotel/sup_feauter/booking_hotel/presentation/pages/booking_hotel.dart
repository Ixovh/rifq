import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/di/setup.dart';
import 'package:rifq/core/theme/app_theme.dart';
import '../../../../../../../core/common/widgets/button/custome_button_widgets.dart';
import '../../domain/usecase/booking_hotel_usecase.dart';
import '../cubit/booking_hotel_cubit.dart';
import '../widgets/date_time.dart';
import '../widgets/pet_name.dart';


class BookingHotel extends StatelessWidget {
    // تأدي غرض نفس ستيتفل
  final ValueNotifier<DateTime?> checkIn = ValueNotifier<DateTime?>(null);
  final ValueNotifier<DateTime?> checkOut = ValueNotifier<DateTime?>(null);

  BookingHotel({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingHotelCubit(getIt<BookingHotelUsecase>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Booking Details",
            style: context.body1.copyWith(color: context.primary300),
          ), centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Name",
                  ),
                ),
                SizedBox(height: 11.h),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
                SizedBox(height: 19.h),
                Text("Choose your pet : ", style: TextStyle(
                    fontSize: 16.sp, fontWeight: FontWeight.bold),),
                SizedBox(height: 8.h),
                SizedBox(
                  height: 66.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      PetNameCardinfoWidgets(),
                      SizedBox(width: 11.w),
                      PetNameCardinfoWidgets(),
                      SizedBox(width: 11.w),
                      PetNameCardinfoWidgets(),
                    ],
                  ),),
                SizedBox(height: 11.h),
                Text("Service : ", style: TextStyle(
                    fontSize: 16.sp, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text("serviceName"),
                    SizedBox(width: 20.w),
                    Text("servicePrice"),
                  ],),
                SizedBox(height: 20.h),
                // Text("Date",style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),

                Text(
                  "Check-in Date",
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),

                ValueListenableBuilder<DateTime?>(
                  valueListenable: checkIn,
                  builder: (context, value, _) {
                    return DateField(
                      label: "Select check-in date",
                      selectedDate: value,
                      onTap: () async {
                        final date = await pickDate(context);
                        if (date != null) {
                          checkIn.value = date;

                          if (checkOut.value != null &&
                              checkOut.value!.isBefore(date)) {
                            checkOut.value = null;
                          }
                        }
                      },
                    );
                  },
                ),

                SizedBox(height: 20.h),


                Text(
                  "Check-out Date",
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 11.h),

                ValueListenableBuilder<DateTime?>(
                  valueListenable: checkOut,
                  builder: (context, value, _) {
                    return DateField(
                      label: "Select check-out date",
                      selectedDate: value,
                      onTap: () async {
                        final checkInDate = checkIn.value;

                        final date = await pickDate(context);

                        if (date != null) {
                          if (checkInDate != null &&
                              date.isBefore(checkInDate)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Check-out must be after check-in"),
                              ),
                            );
                            return;
                          }

                          checkOut.value = date;
                        }
                      },
                    );
                  },
                ),

                SizedBox(height: 60.h),
                CustomeButtonWidgets(
                  titel: 'Book Now',
                  onPressed: () {},
                  buttonWidth: 366.w,
                  buttonhight: 58.h,)

              ],
            ),
          ),
        ),
      ),
    );
  }

}








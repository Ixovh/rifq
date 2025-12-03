import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/hotel_model.dart';
import '../cubit/hotel_cubit.dart';

class HotelInfoTabContent extends StatelessWidget {
  final HotelModel hotel;

  const HotelInfoTabContent({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text("About the Hotel :"),
          Text(hotel.itemDescription),
          SizedBox(height: 12.h),
          Text(" Rules & Requirements : ",style: TextStyle(color:Colors.black),),
          SizedBox(height: 20.h),
          Row(
            children: [
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 12.w),
              Text("Must be vaccinated"),
              SizedBox(width: 20.w),
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 12.w),
              Text("Late Fee Applies"),
            ],),
          Row(
            children: [
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 12.w),
              Text("Pets must be flea-free"),
              SizedBox(width: 20.w),
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 12.w),
              Text("Bring Food if Allergic"),
            ],),
          Row(
            children: [
             Image.asset('assets/images/mdi_checkbox-outline.png'),
             SizedBox(width: 10.w),
             Text("Pet passport required"),
           ],),
          SizedBox(height: 30.h),
          if (hotel.locationUrl != null && hotel.locationUrl!.isNotEmpty)
            //عشان النص و الصوره استخدمت   icon.
            SizedBox(
              width: 339.w,
              height: 26.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<HotelCubit>().openLocation(hotel.locationUrl);
                },
                icon: Icon(Icons.location_on,color: Colors.grey,),
                label: Text("Location",style: TextStyle(color: Colors.black),),
              ),
            ),

        ]
      ),
    );
  }
}

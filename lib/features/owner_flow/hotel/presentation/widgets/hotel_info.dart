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
          SizedBox(height: 16.h),
          Text(" Rules & Requirements : ",style: TextStyle(color:Colors.black),),
          SizedBox(width: 16.w),
          Row(
            children: [
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 10.w),
              Text("Must be vaccinated"),
              SizedBox(width: 20.w),
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 10.w),
              Text("Late Fee Applies"),
            ],),
          Row(
            children: [
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 10.w),
              Text("Pets must be flea-free"),
              SizedBox(width: 20.w),
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 10.w),
              Text("Bring Food if Allergic"),
            ],),
          Row(
            children: [
             Image.asset('assets/images/mdi_checkbox-outline.png'),
             SizedBox(width: 10.w),
             Text("Pet passport required"),
           ],),

          if (hotel.locationUrl != null && hotel.locationUrl!.isNotEmpty)
            ElevatedButton.icon(
              onPressed: () {
                context.read<HotelCubit>().openLocation(hotel.locationUrl);
              },
              icon: Icon(Icons.location_on),
              label: Text("Open Location"),
            ),
          SizedBox(height: 16.h),




        ],
      ),
    );
  }
}

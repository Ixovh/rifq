import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_color.dart';
import 'package:rifq/core/theme/app_theme.dart';

import '../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import '../../../../../core/shared/shared_in_owner_flow/shared/models/provider_items_view_model.dart';
import '../../data/model/hotel_model.dart';
import '../cubit/hotel_cubit.dart';

class HotelInfoTabContent extends StatelessWidget {
  final ProviderItemsViewEntity hotel;
  const HotelInfoTabContent({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text("About the Hotel :",style: context.body3.copyWith(color: context.neutral1000),),
          Text(hotel.itemDescription!,style: TextStyle(fontSize: 12,color: AppColors.neutral700),),
          SizedBox(height: 12.h),
          Text(" Rules & Requirements : ",style: context.body3.copyWith(color: context.neutral1000),),
          SizedBox(height: 20.h),
          Row(
            children: [
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 12.w),
              Text("Must be vaccinated",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.neutral600),),
              SizedBox(width: 20.w),
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 12.w),
              Text("Late Fee Applies",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.neutral600)),
            ],),
          Row(
            children: [
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 12.w),
              Text("Pets must be flea-free",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.neutral600)),
              SizedBox(width: 20.w),
              Image.asset('assets/images/mdi_checkbox-outline.png'),
              SizedBox(width: 12.w),
              Text("Bring Food if Allergic",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.neutral600)),
            ],),
          Row(
            children: [
             Image.asset('assets/images/mdi_checkbox-outline.png',),
             SizedBox(width: 10.w),
             Text("Pet passport required",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.neutral600)),
           ],),
          SizedBox(height: 70.h),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    side: BorderSide(color: AppColors.neutral300,width: 1.w)
                  )
                ),
              ),
            ),

        ]
      ),
    );
  }
}

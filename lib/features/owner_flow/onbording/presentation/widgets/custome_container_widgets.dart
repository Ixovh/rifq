import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custome_button_widgets.dart';

class CustomeContainerWidgets extends StatelessWidget{
  final String title;
  final String subTitle;
  const CustomeContainerWidgets({super.key, required this.title, required this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 402.w,
      height: 425.h,
      padding: EdgeInsets.only(
        top: 28,
        right: 18,
        bottom: 40,
        left: 18,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft:Radius.circular(50),topRight:Radius.circular(50),)
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title,style: TextStyle(color: Color(0xFF4A4A4A),fontSize: 32.sp,fontWeight: FontWeight.w500),),
            SizedBox(height: 16.h),
            Text(subTitle,style: TextStyle(color: Color(0xFF606060),fontSize: 18.sp,fontWeight: FontWeight.w400)),
            SizedBox(height: 80.h,),
            CustomeButtonWidgets
              (titel: 'Next',
              onPressed: () { },
              buttonWidth: 366.w,
              buttonhight: 58.h,),
            SizedBox(height: 16.h),
            TextButton(onPressed: (){},
                child: Text('Skip',style: TextStyle(color: Color(0xFF777777),fontSize: 20.sp,fontWeight: FontWeight.w500),))
          ],

        ),
      ),

    );

  }
}








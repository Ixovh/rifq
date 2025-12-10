import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PetNameCardinfoWidgets extends StatelessWidget {
  final Widget? icon;

  const PetNameCardinfoWidgets({
    super.key,
    this.icon,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 221.w,
      height: 66.h,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.only(top: 1,left: 10,right: 8,bottom: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color:Color(0xFFBBE9E3),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 22.r,
          backgroundColor: Colors.purpleAccent,
          // backgroundImage: AssetImage(pet.photoUrl),
        ),
        title: Text(
          "mkdf",
          // pet.name,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        trailing:IconButton(onPressed: (){},
            icon: Icon(Icons.check_box_outline_blank)),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}


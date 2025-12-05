import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/theme/app_color.dart';
import '../../../../../pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';

class PetName extends StatelessWidget {
  // final PetProfileEntity pet;
  final Widget? icon; // اختياري أيقونة
  final Color? bgColor;

  const PetName({
    super.key,
    // required this.pet,
    this.icon,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 221.w,
      height: 66.h,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.only(top: 1,left: 10,right: 8,bottom: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: bgColor ?? Color(0xFFBBE9E3),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 22.r,
          backgroundColor: Colors.purpleAccent,
          // backgroundImage: AssetImage(pet.photoUrl), // أو Image.network حسب المصدر
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
            icon: Icon(Icons.check_box_outline_blank)), // أيقونة اختيار لو حابة
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}





// Row(
// children: [
// CircleAvatar(
// radius: 22.r,
// backgroundColor: Colors.white,
// child: Image.asset(pet.photoUrl),
// ),
//
// SizedBox(width: 12.w),
// Expanded(
// child: Text(
// pet.name,
// style: TextStyle(
// fontSize: 16.sp,
// fontWeight: FontWeight.w600,
// ),
// ),
//
// )]);
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';

class PetNameCardinfoWidgets extends StatelessWidget {
  final Widget? icon;
  final PetProfileEntity pet;
  final bool isSelected;
  final VoidCallback onTap;

  const PetNameCardinfoWidgets({
    super.key,
    this.icon,
    required this.pet,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 221.w,
        height: 66.h,
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.only(top: 1, left: 10, right: 8, bottom: 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Color(0xFFBBE9E3),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 22.r,
            backgroundImage: pet.photoUrl.isNotEmpty
                ? NetworkImage(pet.photoUrl)
                : null,
            child: pet.photoUrl.isEmpty ? const Icon(Icons.pets) : null,
          ),

          title: Text(
            pet.name,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          trailing: Icon(
            isSelected ? Icons.check_box : Icons.check_box_outline_blank,
            color: isSelected ? Colors.green : Colors.grey,
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_color.dart';
import 'package:rifq/core/theme/app_theme.dart';

import '../../../../../../../core/routes/base_routes.dart';
import '../../domain/entity/pet_entity.dart';
class ContainerPetCardWidgets extends StatelessWidget {
  final PetProfileEntity pet;

  // final String petName;
  // final String gender;
  // final String age;
  // final String breed;
  // final String photo;

  const ContainerPetCardWidgets({
    super.key,
    required this.pet,
    // required this.petName,
    // required this.gender,
    // required this.age,
    // required this.breed,
    // required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240.w,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 4),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pet Profile", style: context.body3.copyWith(color: context.neutral500)
              ),
              IconButton(
                onPressed: () {
                  print(pet);
                    context.push(Routes.editpetprofile, extra: pet);
                    }, icon: Icon(Icons.edit_outlined),
              )

              // IconButton(onPressed: (){
              //   context.push(Routes.editpetprofile);
              //   },
              //     icon: Icon(Icons.edit_outlined, color: AppColors.neutral900))
            ],
          ),

          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Color(0xFFBBE9E3),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: Colors.white,
                  child: Image.network(pet.photoUrl),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: Text(
                    pet.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(onPressed: (){

                },
                    icon: Icon(Icons.arrow_forward_ios,size: 20.r,))
              ],
            ),
          ),
          SizedBox(height: 18.h),
          Text("Gender: ${pet.gender}",style: TextStyle(color: AppColors.neutral500),),
          Text("Age:  ${pet.birthdate}",style: TextStyle(color: AppColors.neutral500),),
          Text("Breed:  ${pet.breed}",style: TextStyle(color: AppColors.neutral500),),
        ],
      ),
    );
  }
}

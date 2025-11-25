
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_color.dart';
import 'package:rifq/core/theme/app_theme.dart';
class ContainerPetCardWidgets extends StatelessWidget {
  final String petName;
  final String gender;
  final String age;
  final String breed;
  final String photo;

  const ContainerPetCardWidgets({
    super.key,
    required this.petName,
    required this.gender,
    required this.age,
    required this.breed,
    required this.photo,
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

          /// Pet Profile + edit icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pet Profile",
                style: context.body3.copyWith(color: context.neutral500)
              ),
              IconButton(onPressed: (){},
                  icon: Icon(Icons.edit_outlined, color: AppColors.neutral900))
            ],
          ),

          SizedBox(height: 12.h),

          /// Card Header with mint background
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
                  child: Image.asset(photo),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: Text(
                    petName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(onPressed: (){}, 
                    icon: Icon(Icons.arrow_forward_ios,size: 20.r,))
              ],
            ),
          ),

          SizedBox(height: 18.h),
          Text("Gender: $gender",style: TextStyle(color: AppColors.neutral500),),
          Text("Age: $age",style: TextStyle(color: AppColors.neutral500),),
          Text("Breed: $breed",style: TextStyle(color: AppColors.neutral500),),
        ],
      ),
    );
  }
}
//
// class ContainerPetCardWidgets extends StatelessWidget {
//   final String petName;
//   final String gender;
//   final String age;
//   final String breed;
//   final String photo; 
//
//   const ContainerPetCardWidgets({
//     super.key,
//     required this.petName,
//     required this.gender,
//     required this.age,
//     required this.breed,
//     required this.photo,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 256.w,
//       padding: EdgeInsets.all(12.r),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//         border: Border.all(
//           color: AppColors.neutral300,
//           width: 1.w,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Pet Profile",
//                 style: TextStyle(
//                   color: AppColors.neutral500,
//                   fontSize: 14.sp,
//                 ),
//               ),
//               Icon(Icons.edit_outlined, color: AppColors.neutral900),
//             ],
//           ),
//
//           SizedBox(height: 12.h),
//
//           /// ------- Main Card Section -------
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
//             decoration: BoxDecoration(
//               color: context.neutral300,
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 22.r,
//                   backgroundColor: Colors.grey.shade300,
//                   backgroundImage: photo.isNotEmpty
//                       ? AssetImage(photo)
//                       : null, // dummy
//                   child: photo.isEmpty
//                       ? Icon(Icons.pets, color: Colors.grey)
//                       : null,
//                 ),
//                 SizedBox(width: 12.w),
//
//                 Expanded(
//                   child: Text(
//                     petName,
//                     style: TextStyle(
//                       color: AppColors.neutral900,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//
//                 Icon(Icons.arrow_forward_ios, size: 16),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 16.h),
//
//           /// ------- Info Row -------
//           Text("Gender: $gender", style: TextStyle(fontSize: 14.sp)),
//           Text("Age: $age", style: TextStyle(fontSize: 14.sp)),
//           Text("Breed: $breed", style: TextStyle(fontSize: 14.sp)),
//         ],
//       ),
//     );
//   }
// }
//
// //
// // class ContainerPetCardWidgets  extends StatelessWidget{
// //   final String petName;
// //   final String gender;
// //   final String age;
// //   final String breed;
// //   final String photo;
// //
// //   const ContainerPetCardWidgets({super.key,
// //     required this.petName,
// //     required this.gender,
// //     required this.age,
// //     required this.breed,
// //     required this.photo,
// //   });
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: 256.w,
// //       height: 177.h,
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(20.r),
// //       ),
// //       child: Column(
// //         children: [
// //           Row(
// //             children: [
// //             Text("Pet Profile",style: TextStyle(
// //                 color:AppColors.neutral500),),
// //             SizedBox(width: 224.w),
// //             IconButton(onPressed: (){},
// //                 icon: Icon(Icons.edit_outlined,color: AppColors.neutral900,))
// //             ],),
// //           Container(
// //             padding: EdgeInsets.only(left: 18.r,right: 17.r,top: 46.r,bottom: 85.r),
// //             width: 221.w,
// //             height: 46.h,
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(8.r),
// //               color: context.neutral300,
// //             ),
// //             child: ListTile(
// //               leading: CircleAvatar(
// //                 radius: 363.5.r,
// //                 backgroundImage: AssetImage(photo),
// //               ),
// //               title: Text(petName),
// //               trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),),
// //
// //           ),
// //           Row(
// //             children: [
// //               Text("Gender : $gender"),
// //               SizedBox(width: 12.w),
// //               Text("Age:  $age"),
// //               SizedBox(width: 12.w),
// //               Text("Breed:  $breed"),
// //             ],
// //           )
// //
// //         ],
// //       ),
// //     );
// //   }
// // }
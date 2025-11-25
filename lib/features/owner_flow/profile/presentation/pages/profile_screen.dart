import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_color.dart';
import '../../../../../core/di/setup.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/user_profile_usecase.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/container_pet/container_pet_card_widgets.dart';
import '../widgets/listtiel/list_tiel_widgets.dart';

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProfileCubit(getIt<UserProfileUsecase>()),
//       child: BlocBuilder<ProfileCubit, ProfileState>(
//         builder: (context, state) {
//           if(state is ProfileLoading){
//             return Center(child: CircularProgressIndicator(),);
//           }
//           if(state is ProfileLoaded){
//
//           }
//           return Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               elevation: 0,
//               leading: IconButton(onPressed: () {},
//                 icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//               ),
//             ),
//
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24.w),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 10.h),
//                     Center(
//                       child: CircleAvatar(
//                         radius: 60.r,
//                         backgroundColor: Color(0xFFBBE9E3),
//                         child: Text("S", style: TextStyle(
//                           fontSize: 48.sp,
//                           color: Colors.white,
//                         ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 16.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Sarah M",
//                           style: TextStyle(
//                             fontSize: 20.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(width: 6.w),
//                         IconButton(
//                             onPressed: () {}, icon: Icon(Icons.edit_outlined,))
//                       ],),
//                     SizedBox(height: 18.h),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // البيانات اللي هنا بتجي من الداتابيس ماراح يكون فيه تعديل وتحقق الا اذا ضغط البوتون
//                         TextField(
//                           decoration: InputDecoration(
//                             hintText: "Email ",
//                           ),
//                         )
//                       ],),
//                     SizedBox(height: 20.h),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextField(
//                           decoration: InputDecoration(
//                             hintText: "Name ",
//                           ),)
//                       ],),
//                     SizedBox(height: 32.h),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           ContainerPetCardWidgets(
//                             petName: "Caty",
//                             gender: "Female",
//                             age: "1 Year",
//                             breed: "British Shorthair",
//                             photo: "assets/images/download.png",
//                           ),
//                           SizedBox(width: 12.w),
//                           ContainerPetCardWidgets(
//                             petName: "Buddy",
//                             gender: "Male",
//                             age: "2 Years",
//                             breed: "Golden Retriever",
//                             photo: "assets/images/download.png",
//                           ),
//                           SizedBox(width: 12.w),
//                           ContainerPetCardWidgets(
//                             petName: "Buddy",
//                             gender: "Male",
//                             age: "2 Years",
//                             breed: "Golden Retriever",
//                             photo: "assets/images/logo (1).png",
//                           ),
//                           SizedBox(width: 12.w),
//                           ContainerPetCardWidgets(
//                             petName: "Buddy",
//                             gender: "Male",
//                             age: "2 Years",
//                             breed: "Golden Retriever",
//                             photo: "assets/images/logo (1).png",
//                           ),
//
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 16.h),
//                     ListTielWidgets(
//                       images: 'assets/images/material.png',
//                       text: 'Security & Privacy',),
//                     SizedBox(height: 13.h),
//                     ListTielWidgets(
//                       images: 'assets/images/material-symbols_language.png',
//                       text: 'Language',),
//                     SizedBox(height: 13.h),
//                     ListTielWidgets(
//                       images: 'assets/images/mdi_logout.png',
//                       text: 'Log out',),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// الكود اللي فوق صصصصح بس قبل البلوك بروفايدر و البيانات تيست
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ProfileCubit(getIt<UserProfileUsecase>())..getUserProfile("eec1fc49-99e3-4589-85b1-c36dd79d7917"),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is ProfileError) {
            return Scaffold(
              body: Center(child: Text(state.message)),
            );
          }
          UserProfileEntity? user;
          if (state is ProfileLoaded) {
            user = state.user;}
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,// عشان الاب بار لما احرك مايتغير لونه
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Center(
                      child: CircleAvatar(
                        radius: 60.r,
                        backgroundColor: Color(0xFFBBE9E3),
                        child: Text(
                          (user?.name ?? "S").substring(0, 1),
                          style: TextStyle(
                            fontSize: 48.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user?.name ?? "",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        IconButton(
                          onPressed: () {

                          },
                          icon: Icon(Icons.edit_outlined),
                        )
                      ],
                    ),

                    SizedBox(height: 18.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: user?.email ?? "Email",
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: user?.name ?? "Name",
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 32.h),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ContainerPetCardWidgets(
                            petName: "Caty",
                            gender: "Female",
                            age: "1 Year",
                            breed: "British Shorthair",
                            photo: "assets/images/download.png",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ListTielWidgets(
                      images: 'assets/images/material.png',
                      text: 'Security & Privacy',
                    ),
                    SizedBox(height: 12.h),
                    ListTielWidgets(
                      icone: IconButton(onPressed: (){},
                          icon: Icon(Icons.language,size: 28,)),                      text: 'Language',
                    ),
                    SizedBox(height: 12.h),
                    ListTielWidgets(
                      text: 'Log out',
                      icone: IconButton(onPressed: (){},
                          icon: Icon(Icons.logout,size: 28,)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}






















// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rifq/core/theme/app_color.dart';
// import '../widgets/container_pet/container_pet_card_widgets.dart';
//
// class ProfileScreen  extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       leading: IconButton(onPressed: (){},
//           icon: Icon(Icons.arrow_back_ios)),),
//     body:SingleChildScrollView(
//       // scrollDirection: .horizontal,
//       child: Container(
//         // decoration: BoxDecoration(
//         //     shape: BoxShape.circle,
//         //     border: Border.all(
//         //     color: AppColors.primary300,
//         //     width: 3.w,
//         //   )),
//         padding: EdgeInsets.only(left: 126.r),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundColor: Color(0xFFBBE9E3),
//               radius: 78.5.r,
//               child: Text("data"),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(" Name"),
//                 // SizedBox(width: 8.61.w,),
//                 IconButton(onPressed: (){},
//                     padding: EdgeInsets.zero,
//                     icon: Icon(Icons.edit_outlined,color: AppColors.neutral900,))
//               ],),
//             TextField(
//               style: TextStyle(color: Color(0xFFA4A4A4)),
//               decoration: InputDecoration(
//                 labelText: "Email",
//               ),
//             ),
//             SizedBox(height: 12.h,),
//             TextField(
//               style: TextStyle(color: Color(0xFFA4A4A4)),
//               decoration: InputDecoration(
//                 labelText: "phone Nummber",
//               ),
//             ),
//             SizedBox(height: 32.h),
//         Row(
//           children: [
//             ContainerPetCardWidgets(
//               petName: "Luna",
//               gender: "Female",
//               age: "2 Years",
//               breed: "Persian",
//               photo: "", // Dummy
//             ),
//
//           ],
//         )
//           ],
//         ),
//       )
//     )
//   );
//   }
// }
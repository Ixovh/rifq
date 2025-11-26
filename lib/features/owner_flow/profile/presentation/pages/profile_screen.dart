import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/di/setup.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/usecases/user_profile_usecase.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/container_pet/container_pet_card_widgets.dart';
import '../widgets/listtiel/list_tiel_widgets.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt<UserProfileUsecase>()),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ProfileCubit>().getUserProfile("52fc04dc-adac-432d-a3a2-20d80e93463f");
          return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if(state is ProfileLoading){
                return Center(child: CircularProgressIndicator(),);
              }
              UserProfileEntity? user;
              if (state is ProfileLoaded) {
                user = state.user;
              }
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(onPressed: () {},
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),),

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
                            child: Text(user != null ? user.name[0].toUpperCase() : "?",
                              style: TextStyle(fontSize: 48.sp, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user != null ? user.name : "Loading...", style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined,))],),
                        SizedBox(height: 18.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // البيانات اللي هنا بتجي من الداتابيس ماراح يكون فيه تعديل وتحقق الا اذا ضغط البوتون
                            TextField(
                              decoration: InputDecoration(
                                hintText: user?.email ?? "Email",
                              ),
                            )],),
                        SizedBox(height: 20.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: user?.name ?? "Name",
                              ),
                            )
                          ],),

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
                              SizedBox(width: 12.w),
                              ContainerPetCardWidgets(
                                petName: "Buddy",
                                gender: "Male",
                                age: "2 Years",
                                breed: "Golden Retriever",
                                photo: "assets/images/download.png",
                              ),
                              SizedBox(width: 12.w),
                              ContainerPetCardWidgets(
                                petName: "Buddy",
                                gender: "Male",
                                age: "2 Years",
                                breed: "Golden Retriever",
                                photo: "assets/images/logo (1).png",
                              ),
                              SizedBox(width: 12.w),
                              ContainerPetCardWidgets(
                                petName: "Buddy",
                                gender: "Male",
                                age: "2 Years",
                                breed: "Golden Retriever",
                                photo: "assets/images/logo (1).png",
                              ),
                            ],),),

                        SizedBox(height: 16.h),
                        ListTielWidgets(
                          images: 'assets/images/material.png',
                          text: 'Security & Privacy',),
                        SizedBox(height: 13.h),
                        ListTielWidgets(
                          icone: IconButton(onPressed: (){},
                              icon: Icon(Icons.language,size: 28.r,)),
                          text: 'Language',),
                        SizedBox(height: 13.h),
                        ListTielWidgets(
                          icone: IconButton(onPressed: (){},
                              icon: Icon(Icons.logout,size: 28.r,)),
                          text: 'Log out',),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}



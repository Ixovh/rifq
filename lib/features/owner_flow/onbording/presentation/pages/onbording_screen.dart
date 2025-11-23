import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/onbording_cubit.dart';
import '../widgets/custome_container_widgets.dart';

class OnbordingScreen extends StatelessWidget{
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> pageImages=[
      //FirstPage
      [Positioned(
          top:93.h,
          left: -8.w,
          child: Image.asset('assets/images/logo (1).png'
            ,width: 320.w,
            height: 299.h,),),
        Positioned(
          top:113.h,
          left: 318.w,
          child: Image.asset('assets/images/Rifq.png'
            ,width: 742.w,
            height: 406.h,),),
        Positioned(
          top:48.h,
          left: 1.w,
          child: Image.asset(
            'assets/images/Eight Tips for Taking.png',
            width: 402.w,
            height: 603.h,),),],

      //SecondPage:
      [ //حرف
        Positioned(
          top:113.h,
          left: -209.w, //  مقاس المصممين -116
          child: Image.asset(
            'assets/images/Rifq2.png',
            width: 817.w,
            height: 406.h,),),
        //صورة الكلب
        Positioned(
          top:1.h,
          left: 13.w,
          child: Image.asset(
            'assets/images/download.png',
            width: 375.w,
            height: 666.h,),),],

      //ThirdPage:
      [ //حرف
        Positioned(
          top:111.h,
          left: -260.w,// مقاس المصممين -503px
          child: Image.asset(
            'assets/images/Rifq3.png',
            width: 900.w,
            height: 406.h,),),

        //صورة الجوال
        Positioned(
          top:134.h,
          left: -20.w,
          child: Image.asset(
            'assets/images/Free iPhone 15 Pro Hand Mockup .png',
            width: 377.w,
            height: 351.h,),),],];

    final List<String>title=[
      'Welcome to Rifq!',
      'Track Your Pet’s \n Health Easily',
      'Smart Care, Anytime'];
    final List<String>subTitle=[
      'Your all-in-one app for caring, tracking,\n and supporting every moment of your \n pet’s life.',
      'Keep all medical records, vaccinations,\n and check-ups organized in one smart \n health card.',
      'Use AI to check symptoms,\n find nearby clinics, home services, \n hotels,and everything your pet needs.'
    ];

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors:[
          Color(0xFFBBE9E3),
          Color(0xFFFFFFFF),
        ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: BlocProvider(
        create: (context) => OnbordingCubit(), 
        child: BlocBuilder<OnbordingCubit, int>(
  builder: (context, state) {
    return Scaffold(
          backgroundColor: Colors.transparent,
          body:PageView.builder(
              controller: controller,
              itemCount: 3,
              onPageChanged: (index){
                context.read<OnbordingCubit>().changePage(index);
              },
              itemBuilder: (context,index){
                return Column(
                  children: [
                    SizedBox(
                      height: 0.5.sh,
                      width: double.infinity,
                      child: Stack(
                          children: pageImages[index]
                      ),
                    ),
                    CustomeContainerWidgets(
                      title: title[index],
                      subTitle: subTitle[index],
                      pageIndex: state,
                      controller: controller,
                    ), ],
                );

              })
      );
  },
),
),
    );
  }
}


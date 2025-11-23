import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custome_container_widgets.dart';

class OnbordingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> pageImages=[
      //FirstPage
      [
        Positioned(
          top:93.h,
          left: -8.w,
          child: Image.asset('assets/imeges/logo (1).png'
            ,width: 320.w,
            height: 299.h,),),
        Positioned(
          top:113.h,
          left: 318.w,
          child: Image.asset('assets/imeges/Rifq.png'
            ,width: 742.w,
            height: 406.h,),),
        Positioned(
          top:48.h,
          left: 1.w,
          child: Image.asset(
            'assets/imeges/Eight Tips for Taking Good Care of Your Chihuahua\'s Paws 1.png',
            width: 402.w,
            height: 603.h,),),],
      //SecondPage:
      [ //حرف
        Positioned(
          top:113.h,
          left: -116.w,
          child: Image.asset(
            'assets/imeges/Rifq2.png',
            width: 817.w,
            height: 406.h,),),
        //صورة الكلب
        Positioned(
          top:1.h,
          left: 13.w,
          child: Image.asset(
            'assets/imeges/download.png',
            width: 375.w,
            height: 666.h,),),],

      //ThirdPage:
      [ //حرف
        Positioned(
          top:111.h,
          left: -503.w,
          child: Image.asset(
            'assets/imeges/Rifq3.png',
            width: 900.w,
            height: 406.h,),),

        //صورة الجوال
        Positioned(
          top:134.h,
          left: -20.w,
          child: Image.asset(
            'assets/imeges/Free iPhone 15.png',
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
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body:PageView.builder(
              itemCount: 3,
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
                      subTitle: subTitle[index],)
                  ],
                );

              })
      ),
    );
  }
}
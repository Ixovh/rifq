import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/features/owner_flow/onbording/presentation/cubit/onbording_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../core/theme/app_color.dart';
import 'custome_button_widgets.dart';

class CustomeContainerWidgets extends StatelessWidget{
  final String title;
  final String subTitle;
  final int pageIndex;
  final PageController controller;

  const CustomeContainerWidgets({
    super.key, required this.title,
    required this.subTitle,
    required this.pageIndex,
    required this.controller,
  });
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
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: CustomizableEffect(
                spacing: 12,
                dotDecoration: DotDecoration(
                  width: 18.w,
                  height: 18.w,
                  color: Colors.white,
                  dotBorder: DotBorder(
                    color: AppColors.primary200,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                activeDotDecoration: DotDecoration(
                  width: 22,
                  height: 22,
                  color:AppColors.primary200,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),

            Text(title,style: TextStyle(color: AppColors.neutral900,fontSize:32.sp,fontWeight: FontWeight.w500)),
            SizedBox(height: 18.h),
            Text(subTitle,textAlign: TextAlign.center,style: TextStyle(color: AppColors.neutral800,fontSize:18.sp,fontWeight: FontWeight.w400)),
            SizedBox(height: 24.h,),
            // if(pageIndex == 2) // last pageS
            //   CustomeButtonWidgets(
            //     titel: 'Get Started',
            //     onPressed: () { },
            //     buttonWidth: 366.w,
            //     buttonhight: 58.h,
            //   )
            // else ...[
            //   CustomeButtonWidgets(
            //     titel: 'Next',
            //     onPressed: () {
            //       print("Button clicked!!!");
            //       print("object  $pageIndex");
            //       context.read<OnbordingCubit>().nextPage();
            //       controller.nextPage(duration: Duration(milliseconds: 300),
            //           curve: Curves.ease);
            //     },
            //     buttonWidth: 366.w,
            //     buttonhight: 58.h,
            //   ),
            //   SizedBox(height: 18.h),
            //   TextButton(
            //     onPressed: (){
            //       print("skiip  $pageIndex");
            //       context.read<OnbordingCubit>().skip();
            //       controller.jumpToPage(2);
            //     },
            //     child: Text('Skip',style: TextStyle(color: Color(0xFF777777),fontSize: 20.sp,fontWeight: FontWeight.w500), ),
            //   ),
            // ],
          ],

    )));


  }
}




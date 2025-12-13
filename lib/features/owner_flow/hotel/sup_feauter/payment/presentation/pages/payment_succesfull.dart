// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rifq/core/theme/app_theme.dart';
//
// import '../../../../../../../core/common/widgets/button/custome_button_widgets.dart';
//
// class PaymentSuccesfull extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment:.center,
//             children: [
//               Image.asset('assets/images/payment_successfull.png'),
//               Text("Payment Successfully",style:  context.h3.copyWith(color: context.primary300)),
//               SizedBox(height: 10.h),
//               Text("Payment successful your hotel booking is now \n confirmed.",style: context.body2.copyWith(color: context.neutral800),),
//
//               SizedBox(height: 30.h),
//
//               CustomeButtonWidgets(
//                 titel: 'See Details',
//                 onPressed: () {  },
//                 buttonWidth: 366.w,
//                 buttonhight: 58.h,),
//
//               SizedBox(height: 17.h),
//               TextButton(onPressed: (){},
//                   child: Text("Back",style: context.h5.copyWith(color: context.primary300),))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/theme/app_theme.dart';

import '../../../../../../../core/common/widgets/button/custome_button_widgets.dart';
import '../../../../../../../core/routes/base_routes.dart';

class PaymentSuccesfull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/payment_successfull.png',
                    width: 150.w,
                    height: 150.h,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Payment Successfully",
                    style: context.h5.copyWith(color: context.primary300),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Payment successful! Your hotel booking is now confirmed.",
                    style: context.body2.copyWith(color: context.neutral800),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  CustomeButtonWidgets(
                    titel: 'See Details',
                    onPressed: () {},
                    buttonhight: 58.h,
                    buttonWidth: 366.w,
                  ),
                  SizedBox(height: 17.h),
                  TextButton(
                    onPressed: () {
                      context.pushReplacement(Routes.hotel);
                    },
                    child: Text(
                      "Back",
                      style: context.h5.copyWith(color: context.primary300),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

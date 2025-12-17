import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/theme/app_theme.dart';
import '../../../../../../../core/routes/base_routes.dart';

class PaymentSuccesfull extends StatelessWidget {
  const PaymentSuccesfull({super.key});
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
                  SizedBox(height: 17.h),
                  TextButton(
                    onPressed: () {
                      context.pushReplacement(Routes.navbar);
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

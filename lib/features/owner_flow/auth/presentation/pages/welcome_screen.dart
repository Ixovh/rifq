import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import '../../../../../core/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/container_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .start,
          children: [
            Center(child: SvgPicture.asset('assets/icon/logo.svg')),

            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(left: 18.r),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Welcome to Rifq',
                      style: context.h3.copyWith(color: context.primary300),
                    ),
                    Text(
                      'Your trusted space for pet care and services.',
                      style: context.bodyLarge.copyWith(
                        color: context.neutral700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(18.r),
                child: Column(
                  children: [
                    Text(
                      'Sign in to continue caring with ease.',
                      style: context.bodyMedium.copyWith(
                        color: context.neutral900,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    ContainerButton(
                      label: 'Sign in',
                      containerColor: context.primary300,
                      textColor: context.neutral100,
                      fontSize: 20,
                      onTap: () {
                        context.go(Routes.auth);
                      },
                    ),
                    SizedBox(height: 18.h),
                    ContainerButton(
                      label: 'Continue as Guest',
                      containerColor: context.neutral100,
                      textColor: context.primary300,
                      fontSize: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

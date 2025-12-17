import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/nav/presentation/cubit/nav_cubit.dart';
import 'package:rifq/features/owner_flow/nav/presentation/cubit/nav_state.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = context.read<NavCubit>();
        return BlocBuilder<NavCubit, NavState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false, // Keep navbar fixed at bottom
              backgroundColor: context.background,
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: context.background,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 12.w,
                          right: 12.w,
                          top: 10.h,
                          bottom: 15.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Home
                            Flexible(
                              child: GestureDetector(
                                onTap: () => cubit.changeIndex(index: 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      cubit.currentIndex == 0
                                          ? 'assets/images/home-2f.png'
                                          : 'assets/images/home-2.png',
                                      height: 24.h,
                                      width: 24.w,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 3.h),
                                    Text(
                                      "Home",
                                      style: cubit.currentIndex == 0
                                          ? context.body3.copyWith(
                                              color: context.primary50,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                            )
                                          : context.body3.copyWith(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Health
                            Flexible(
                              child: GestureDetector(
                                onTap: () => cubit.changeIndex(index: 1),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      cubit.currentIndex == 1
                                          ? 'assets/images/heart-addf.png'
                                          : 'assets/images/heart-add.png',
                                      height: 24.h,
                                      width: 24.w,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 3.h),
                                    Text(
                                      "Health",
                                      style: cubit.currentIndex == 1
                                          ? context.body3.copyWith(
                                              color: context.primary50,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                            )
                                          : context.body3.copyWith(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Spacer for FAB - creates gap between Health and Hotel
                            SizedBox(width: 50.w),
                            // Hotel
                            Flexible(
                              child: GestureDetector(
                                onTap: () => cubit.changeIndex(index: 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      cubit.currentIndex == 2
                                          ? 'assets/images/house-2f.png'
                                          : 'assets/images/house-2.png',
                                      height: 24.h,
                                      width: 24.w,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 3.h),
                                    Text(
                                      "Hotel",
                                      style: cubit.currentIndex == 2
                                          ? context.body3.copyWith(
                                              color: context.primary50,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                            )
                                          : context.body3.copyWith(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Adoption
                            Flexible(
                              child: GestureDetector(
                                onTap: () => cubit.changeIndex(index: 3),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      cubit.currentIndex == 3
                                          ? 'assets/images/petf.png'
                                          : 'assets/images/pet.png',
                                      height: 24.h,
                                      width: 24.w,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 3.h),
                                    Text(
                                      "Adoption",
                                      style: cubit.currentIndex == 3
                                          ? context.body3.copyWith(
                                              color: context.primary50,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                            )
                                          : context.body3.copyWith(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Ask AI Button - Fixed position in center, above nav bar
                      // Positioned absolutely to prevent movement when snackbars appear
                      Positioned(
                        bottom: 45.h,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FloatingActionButton(
                                elevation: 4.sp,
                                shape: const CircleBorder(),
                                backgroundColor: context.primary50,
                                onPressed: () {
                                  context.push(Routes.aiScreen);
                                  cubit.setAiActive();
                                },
                                child: Image.asset(
                                  'assets/images/Vector(1).png',
                                  height: 24.h,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'Ask AI',
                                style: context.body3.copyWith(
                                  color: context.primary50,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              body: cubit.screens[cubit.currentIndex],
            );
          },
        );
      },
    );
  }
}

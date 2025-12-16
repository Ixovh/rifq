import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              resizeToAvoidBottomInset: true, //عشان يثبت زر الai
              backgroundColor: context.background,

              floatingActionButton: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 16),
                  FloatingActionButton(
                    elevation: 4,
                    shape: const CircleBorder(),
                    backgroundColor: context.primary50,
                    onPressed: () {
                      context.push(Routes.aiScreen);
                      cubit.setAiActive();
                    },
                    child: Image.asset(
                      'assets/images/Vector(1).png',
                      height: 24,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Ask AI',
                    style: context.body3.copyWith(
                      color: context.primary50,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.noAnimation,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: context.background,
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,

                onTap: (value) {
                  cubit.changeIndex(index: value);
                },

                selectedItemColor: context.primary50,
                unselectedItemColor: Colors.grey,

                selectedLabelStyle: context.body3.copyWith(
                  fontWeight: FontWeight.w600,
                ),

                unselectedLabelStyle: context.body3.copyWith(
                  fontWeight: FontWeight.w400,
                ),

                items: [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: Image.asset('assets/images/home-2.png', height: 24),
                    activeIcon: Image.asset(
                      'assets/images/home-2f.png',
                      height: 24,
                    ),
                  ),

                  BottomNavigationBarItem(
                    label: "Health",
                    icon: Image.asset(
                      'assets/images/heart-add.png',
                      height: 24,
                    ),
                    activeIcon: Image.asset(
                      'assets/images/heart-addf.png',
                      height: 24,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Hotel",
                    icon: Image.asset('assets/images/house-2.png', height: 24),
                    activeIcon: Image.asset(
                      'assets/images/house-2f.png',
                      height: 24,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Adoption",
                    icon: Image.asset('assets/images/pet.png', height: 24),
                    activeIcon: Image.asset(
                      'assets/images/petf.png',
                      height: 24,
                    ),
                  ),
                ],
              ),

              body: cubit.screens[cubit.currentIndex],
            );
          },
        );
      },
    );
  }
}

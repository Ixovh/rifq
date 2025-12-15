import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
             floatingActionButton:

              FloatingActionButton(
              shape:  CircleBorder(),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("data 12"),behavior: .floating,));
                  // context.push(Routes.aiScreen);
                  cubit.changeIndex(index: 2);
                },
                backgroundColor: context.primary50,
                child: Image.asset(
                  'assets/images/Vector(1).png',
                  height: 24,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
                  floatingActionButtonAnimator: .noAnimation,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: context.background,
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,

                onTap: (value) {
                  // print(value);
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
              // backgroundColor: context.background,
            );
          },
        );
      },
    );
  }
}

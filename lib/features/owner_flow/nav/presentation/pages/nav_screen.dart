import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/features/owner_flow/nav/presentation/cubit/nav_cubit.dart';
import 'package:rifq/features/owner_flow/nav/presentation/cubit/nav_state.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavCubit>();
    return BlocBuilder<NavCubit, NavState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              // print(value);
              cubit.changeIndex(index: value);
            },
            items: [
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: "Login", icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: "Login", icon: Icon(Icons.home)),
            ],
          ),

          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}

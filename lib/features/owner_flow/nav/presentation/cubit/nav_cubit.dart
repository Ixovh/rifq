import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/features/owner_flow/health/health_screen.dart';
import 'package:rifq/features/owner_flow/home/presentation/pages/home_screen.dart';
import 'package:rifq/features/owner_flow/hotel/presentation/pages/hotel_home_screen.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/profile_screen.dart';

import 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  List<Widget> screens = [HomeScreen(),HealthScreen(),HotelHomeScreen(),ProfileScreen(userId: '',)];
  int currentIndex = 0;
  NavCubit() : super(NavInitialState());

  void changeIndex({required int index}) {
    emit(NavLoadingState());
    currentIndex = index;
    emit(NavLoadedState());
  }

  @override
  Future<void> close() {
    //here is when close cubit
    return super.close();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/home_screen.dart';

import 'nav_state.dart';

class NavCubit extends Cubit<NavState> {
  List<Widget> screens = [HomeScreen(),HomeScreen()];
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
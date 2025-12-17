import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rifq/features/services_provider_flow/home/presentation/pages/provider_home_screen.dart';
import 'package:rifq/features/services_provider_flow/profile/presentation/pages/provider_profile_screen.dart';
import 'provider_nav_state.dart';

class ProviderNavCubit extends Cubit<ProviderNavState> {
  List<Widget> screens = [
    const ProviderHomeScreen(),
    const ProviderProfileScreen(),
  ];
  int currentIndex = 0;
  ProviderNavCubit() : super(ProviderNavInitialState());

  void changeIndex({required int index}) {
    emit(ProviderNavLoadingState());
    currentIndex = index;
    emit(ProviderNavLoadedState());
  }

  @override
  Future<void> close() => super.close();
}

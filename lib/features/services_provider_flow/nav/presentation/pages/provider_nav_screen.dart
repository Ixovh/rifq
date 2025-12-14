import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rifq/core/di/setup.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/services_provider_flow/auth/data/datasources/provider_atuh_data_source.dart';
import 'package:rifq/features/services_provider_flow/home/data/datasources/reservation_data_source.dart';
import 'package:rifq/features/services_provider_flow/home/domain/usecases/reservation_usecase.dart';
import 'package:rifq/features/services_provider_flow/home/presentation/cubit/home_cubit.dart';
import 'package:rifq/features/services_provider_flow/home/presentation/pages/provider_home_screen.dart';
import 'package:rifq/features/services_provider_flow/nav/presentation/cubit/provider_nav_cubit.dart';
import 'package:rifq/features/services_provider_flow/nav/presentation/cubit/provider_nav_state.dart';
import 'package:rifq/features/services_provider_flow/profile/presentation/pages/provider_profile_screen.dart';

class ProviderNavScreen extends StatelessWidget {
  const ProviderNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = context.read<ProviderNavCubit>();
        return BlocBuilder<ProviderNavCubit, ProviderNavState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: context.background,
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: context.background,
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (value) {
                  cubit.changeIndex(index: value);
                },
                selectedItemColor: context.primary,
                unselectedItemColor: context.neutral500,
                selectedLabelStyle: context.body3.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: context.body3.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                items: [
                  BottomNavigationBarItem(
                    label: "Requests",
                    icon: SvgPicture.asset(
                      'assets/icon/notification-status.svg',
                      width: 24.w,
                      height: 24.h,
                      colorFilter: ColorFilter.mode(
                        cubit.currentIndex == 0
                            ? context.primary
                            : context.neutral500,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Profile",
                    icon: SvgPicture.asset(
                      'assets/icon/frame.svg',
                      width: 24.w,
                      height: 24.h,
                      colorFilter: ColorFilter.mode(
                        cubit.currentIndex == 1
                            ? context.primary
                            : context.neutral500,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
              body: _buildScreen(context, cubit.currentIndex),
            );
          },
        );
      },
    );
  }

  Widget _buildScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        return BlocProvider(
          create: (context) => HomeCubit(
            getIt.get<ReservationUseCase>(),
            getIt.get<ProviderBaseAuthDataSource>(),
            getIt.get<BaseReservationDataSource>(),
          )..loadHomeData(),
          child: const ProviderHomeScreen(),
        );
      case 1:
        return const ProviderProfileScreen();
      default:
        return const SizedBox.shrink();
    }
  }
}

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
import 'package:rifq/features/services_provider_flow/nav/presentation/cubit/provider_nav_cubit.dart';
import 'package:rifq/features/services_provider_flow/nav/presentation/cubit/provider_nav_state.dart';
import 'package:rifq/features/services_provider_flow/nav/presentation/widget/build_screen.dart';
import 'package:rifq/features/services_provider_flow/profile/domain/usecases/provider_profile_usecase.dart';
import 'package:rifq/features/services_provider_flow/profile/presentation/cubit/provider_profile_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProviderNavScreen extends StatelessWidget {
  const ProviderNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authId = Supabase.instance.client.auth.currentUser?.id ?? '';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
            getIt.get<ReservationUseCase>(),
            getIt.get<ProviderBaseAuthDataSource>(),
            getIt.get<BaseReservationDataSource>(),
          )..loadHomeData(),
        ),
        BlocProvider(
          create: (context) =>
              ProviderProfileCubit(getIt.get<ProviderProfileUsecase>())
                ..getProviderProfile(authId),
        ),
      ],
      child: Builder(
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
                body: BuildScreen(context: context, index: cubit.currentIndex),
              );
            },
          );
        },
      ),
    );
  }
}

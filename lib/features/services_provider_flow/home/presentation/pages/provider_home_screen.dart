import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/services_provider_flow/home/presentation/cubit/home_cubit.dart';
import 'package:rifq/features/services_provider_flow/home/presentation/widgets/reservation_card.dart';
import '../../../../../core/common/widgets/lottie_loading/lottie_loding.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProviderHomeCubit>();
    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        backgroundColor: context.background,
        elevation: 0,
        title: SvgPicture.asset(
          'assets/icon/logo.svg',
          width: 50.w,
          height: 50.h,
        ),
      ),
      body: BlocConsumer<ProviderHomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: context.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: LottieLoding());
          }

          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.sp, color: context.error),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    style: context.bodyLarge.copyWith(color: context.error),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () {
                      cubit.loadHomeData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.primary,
                    ),
                    child: Text(
                      'Retry',
                      style: context.bodyMedium.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is HomeLoaded) {
            if (state.serviceTypeId == null) {
              return Center(
                child: Text(
                  'No service type configured',
                  style: context.bodyLarge.copyWith(color: context.neutral600),
                ),
              );
            }

            return RefreshIndicator(
              color: context.primary,
              backgroundColor: context.background,
              onRefresh: () async {
                cubit.loadHomeData();
              },
              child: state.reservations.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 64.sp,
                            color: context.neutral500,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No reservations yet',
                            style: context.bodyLarge.copyWith(
                              color: context.neutral600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      itemCount: state.reservations.length,
                      itemBuilder: (context, index) {
                        final reservation = state.reservations[index];
                        return ReservationCard(
                          reservation: reservation,
                          isClinic: state.isClinic,
                          isBoarding: state.isBoarding,
                          onAccept: () {
                            cubit.acceptReservation(reservation.id);
                          },
                          onReject: () {
                            cubit.rejectReservation(reservation.id);
                          },
                        );
                      },
                    ),
            );
          }

          if (state is ReservationActionLoading) {
            // Show loading overlay while action is processing
            final loadedState = state;
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    cubit.loadHomeData();
                  },
                  child: loadedState.reservations.isEmpty
                      ? Center(
                          child: Text(
                            'No reservations yet',
                            style: context.bodyLarge.copyWith(
                              color: context.neutral600,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          itemCount: loadedState.reservations.length,
                          itemBuilder: (context, index) {
                            final reservation = loadedState.reservations[index];
                            return ReservationCard(
                              reservation: reservation,
                              isClinic: loadedState.isClinic,
                              isBoarding: loadedState.isBoarding,
                              onAccept: () {
                                cubit.acceptReservation(reservation.id);
                              },
                              onReject: () {
                                cubit.rejectReservation(reservation.id);
                              },
                            );
                          },
                        ),
                ),
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: LottieLoding(),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

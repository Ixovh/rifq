import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/reservation_entity.dart';
import 'package:rifq/features/services_provider_flow/home/presentation/cubit/home_cubit.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        backgroundColor: context.background,
        elevation: 0,
        title: Text('Reservations', style: context.headingMedium),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
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
            return Center(
              child: CircularProgressIndicator(color: context.primary),
            );
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
                      context.read<HomeCubit>().loadHomeData();
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
                context.read<HomeCubit>().loadHomeData();
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
                            context.read<HomeCubit>().acceptReservation(
                              reservation.id,
                            );
                          },
                          onReject: () {
                            context.read<HomeCubit>().rejectReservation(
                              reservation.id,
                            );
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
                    context.read<HomeCubit>().loadHomeData();
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
                                context.read<HomeCubit>().acceptReservation(
                                  reservation.id,
                                );
                              },
                              onReject: () {
                                context.read<HomeCubit>().rejectReservation(
                                  reservation.id,
                                );
                              },
                            );
                          },
                        ),
                ),
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: CircularProgressIndicator(color: context.primary),
                  ),
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

class ReservationCard extends StatelessWidget {
  final ReservationEntity reservation;
  final bool isClinic;
  final bool isBoarding;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const ReservationCard({
    super.key,
    required this.reservation,
    required this.isClinic,
    required this.isBoarding,
    required this.onAccept,
    required this.onReject,
  });

  Color _getStatusColor(BuildContext context) {
    switch (reservation.status.toLowerCase()) {
      case 'pending':
        return context.warning;
      case 'accepted':
        return context.success;
      case 'rejected':
        return context.error;
      default:
        return context.neutral500;
    }
  }

  String _getStatusText() {
    switch (reservation.status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'accepted':
        return 'Accepted';
      case 'rejected':
        return 'Rejected';
      default:
        return reservation.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reservation #${reservation.id.substring(0, 8)}',
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(context).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    _getStatusText(),
                    style: context.bodySmall.copyWith(
                      color: _getStatusColor(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Pet information
            if (reservation.pet != null) ...[
              Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundColor: context.primary100,
                    backgroundImage: reservation.pet!.photoUrl.isNotEmpty
                        ? NetworkImage(reservation.pet!.photoUrl)
                        : null,
                    child: reservation.pet!.photoUrl.isEmpty
                        ? Icon(Icons.pets, color: context.primary, size: 24.sp)
                        : null,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reservation.pet!.name,
                          style: context.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '${reservation.pet!.breed} • ${reservation.pet!.species}',
                          style: context.bodySmall.copyWith(
                            color: context.neutral600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
            // Dates - Show different info for clinic vs boarding
            if (isBoarding && reservation.startDate != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16.sp,
                    color: context.neutral600,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Check-in: ${dateFormat.format(reservation.startDate!)}',
                    style: context.bodyMedium.copyWith(
                      color: context.neutral700,
                    ),
                  ),
                ],
              ),
              if (reservation.endDate != null) ...[
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16.sp,
                      color: context.neutral600,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Check-out: ${dateFormat.format(reservation.endDate!)}',
                      style: context.bodyMedium.copyWith(
                        color: context.neutral700,
                      ),
                    ),
                  ],
                ),
              ],
            ] else if (isClinic && reservation.startDate != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16.sp,
                    color: context.neutral600,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '${dateFormat.format(reservation.startDate!)} at ${timeFormat.format(reservation.startDate!)}',
                    style: context.bodyMedium.copyWith(
                      color: context.neutral700,
                    ),
                  ),
                ],
              ),
            ],
            // Notes
            if (reservation.notes != null && reservation.notes!.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: context.neutral200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.note_outlined,
                      size: 16.sp,
                      color: context.neutral600,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        reservation.notes!,
                        style: context.bodySmall.copyWith(
                          color: context.neutral700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            // Action buttons
            if (reservation.status.toLowerCase() == 'pending') ...[
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: context.error),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Reject',
                        style: context.bodyMedium.copyWith(
                          color: context.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.success,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Accept',
                        style: context.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

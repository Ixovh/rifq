import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:rifq/core/di/setup.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/services_provider_flow/home/domain/entities/reservation_entity.dart';
import 'package:rifq/features/services_provider_flow/home/domain/usecases/reservation_usecase.dart';
import 'package:rifq/features/services_provider_flow/home/presentation/widgets/appointment_info_card.dart';
import 'package:rifq/features/services_provider_flow/home/presentation/widgets/treatment_input_section.dart';

class VisitDetailsScreen extends StatelessWidget {
  final ReservationEntity reservation;

  const VisitDetailsScreen({super.key, required this.reservation});

  String _calculateAge(DateTime birthdate) {
    final now = DateTime.now();
    int years = now.year - birthdate.year;
    int months = now.month - birthdate.month;

    if (months < 0) {
      years--;
      months += 12;
    }

    if (years > 0) {
      return years == 1 ? '1 year' : '$years years';
    } else if (months > 0) {
      return months == 1 ? '1 month' : '$months months';
    } else {
      final days = now.difference(birthdate).inDays;
      return days == 1 ? '1 day' : '$days days';
    }
  }

  String _getGenderIcon(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return '♂';
      case 'female':
        return '♀';
      default:
        return '';
    }
  }

  Color _getGenderColor(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return Colors.blue;
      case 'female':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return context.warning;
      case 'accepted':
        return context.success;
      case 'completed':
        return context.success;
      case 'rejected':
        return context.error;
      default:
        return context.neutral500;
    }
  }

  Future<void> _loadServiceItemName(String serviceItemId) async {
    final useCase = getIt<ReservationUseCase>();
    await useCase.getServiceItemName(serviceItemId);
  }

  Future<void> _refreshData(String serviceItemId) async {
    await _loadServiceItemName(serviceItemId);
  }

  @override
  Widget build(BuildContext context) {
    if (reservation.pet == null) {
      return Scaffold(
        backgroundColor: context.background,
        appBar: AppBar(
          backgroundColor: context.background,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: context.primary300),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Visit Details',
            style: context.body1.copyWith(color: context.primary300),
          ),
        ),
        body: Center(
          child: Text(
            'Pet information not available',
            style: context.bodyLarge.copyWith(color: context.error),
          ),
        ),
      );
    }

    final pet = reservation.pet!;
    final dateFormat = DateFormat('EEEE, MMM d');
    final timeFormat = DateFormat('hh:mm a');

    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        backgroundColor: context.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: context.primary300),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Visit Details',
          style: context.body1.copyWith(color: context.primary300),
        ),
      ),
      body: RefreshIndicator(
        color: context.primary,
        backgroundColor: context.background,
        onRefresh: () => _refreshData(reservation.serviceItemId),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Pet Profile Section
              SizedBox(height: 20.h),
              Stack(
                children: [
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: context.primary100, width: 3),
                    ),
                    child: ClipOval(
                      child: pet.photoUrl.isNotEmpty
                          ? Image.network(
                              pet.photoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return SvgPicture.asset('assets/icon/logo.svg');
                              },
                            )
                          : SvgPicture.asset('assets/icon/logo.svg'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(pet.name, style: context.headingMedium),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getGenderColor(pet.gender).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      _getGenderIcon(pet.gender),
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: _getGenderColor(pet.gender),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                pet.breed,
                style: context.bodyMedium.copyWith(color: context.neutral600),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        size: 18.sp,
                        color: context.neutral600,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _calculateAge(pet.birthdate),
                        style: context.bodySmall.copyWith(
                          color: context.neutral600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 24.w),
                  Row(
                    children: [
                      Icon(
                        Icons.pets_sharp,
                        size: 18.sp,
                        color: context.neutral600,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        pet.species,
                        style: context.bodySmall.copyWith(
                          color: context.neutral600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              // Appointment Info Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Appointment info',
                  style: context.body1.copyWith(color: context.primary300),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 120.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    AppointmentInfoCard(
                      icon: Icons.access_time,
                      label: 'Date & time',
                      value: reservation.startDate != null
                          ? '${dateFormat.format(reservation.startDate!)}\n${timeFormat.format(reservation.startDate!)}'
                          : 'Not set',
                      isTwoLine: true,
                    ),
                    SizedBox(width: 12.w),
                    FutureBuilder<String?>(
                      future: getIt<ReservationUseCase>()
                          .getServiceItemName(reservation.serviceItemId)
                          .then(
                            (result) => result.when(
                              (success) => success ?? 'Service',
                              (error) => 'Service',
                            ),
                          ),
                      builder: (context, snapshot) {
                        return AppointmentInfoCard(
                          icon: Icons.favorite_outline,
                          label: 'Service Type',
                          value: snapshot.data ?? 'Loading...',
                          isTwoLine: false,
                        );
                      },
                    ),
                    SizedBox(width: 12.w),
                    AppointmentInfoCard(
                      icon: Icons.person_outline,
                      label: 'Status',
                      value: reservation.status,
                      isTwoLine: false,
                      statusColor: _getStatusColor(context, reservation.status),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Visit Summary Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Visit Summary', style: context.headingSmall),
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: context.neutral200.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  reservation.notes ?? 'No summary available yet.',
                  style: context.bodyMedium.copyWith(color: context.neutral700),
                ),
              ),

              SizedBox(height: 32.h),

              // Treatment & Recommendations Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Treatment & Recommendations',
                  style: context.headingSmall,
                ),
              ),
              SizedBox(height: 16.h),
              TreatmentInputSection(reservationId: reservation.id),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}

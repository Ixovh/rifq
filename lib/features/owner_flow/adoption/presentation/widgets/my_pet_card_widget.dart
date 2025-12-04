import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';

class MyPetCardWidget extends StatelessWidget {
  final AddPetEntity pet;
  final String? location;
  final int requestCount;
  final VoidCallback? onTap;
  final VoidCallback? onRequestsTap;

  const MyPetCardWidget({
    super.key,
    required this.pet,
    this.location,
    this.requestCount = 0,
    this.onTap,
    this.onRequestsTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: context.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          shadows: [
            BoxShadow(
              color: const Color(0x3F656565),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pet Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: _buildPetImage(context),
            ),

            // Pet Info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.r, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Gender Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Name
                      Expanded(
                        child: Text(
                          pet.name,
                          style: context.body1.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                            color: context.neutral900,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Gender Icon
                      _buildGenderIcon(context),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Breed
                  Text(
                    pet.breed,
                    style: context.body2.copyWith(
                      color: context.neutral600,
                      fontSize: 14.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 12.h),

                  // Age Row (only show if we have birthdate)
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16.r,
                        color: context.primary300,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        _formatAge(pet.birthdate),
                        style: context.body2.copyWith(
                          color: context.neutral600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Requests Button
                  if (requestCount > 0)
                    GestureDetector(
                      onTap: onRequestsTap,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: context.primary100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$requestCount Request${requestCount == 1 ? '' : 's'}',
                              style: context.body2.copyWith(
                                color: context.primary300,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14.r,
                              color: context.primary300,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetImage(BuildContext context) {
    final isNetworkUrl =
        pet.photoUrl.startsWith('http://') ||
        pet.photoUrl.startsWith('https://');

    if (isNetworkUrl) {
      return Image.network(
        pet.photoUrl,
        width: double.infinity,
        height: 204.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 204.h,
            color: context.neutral200,
            child: Icon(Icons.pets, size: 48.r, color: context.neutral500),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: double.infinity,
            height: 204.h,
            color: context.neutral200,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
                color: context.primary300,
              ),
            ),
          );
        },
      );
    } else {
      return Image.asset(
        pet.photoUrl,
        width: double.infinity,
        height: 204.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 204.h,
            color: context.neutral200,
            child: Icon(Icons.pets, size: 48.r, color: context.neutral500),
          );
        },
      );
    }
  }

  Widget _buildGenderIcon(BuildContext context) {
    final isMale = pet.gender.toLowerCase() == 'male';
    return Icon(
      isMale ? Icons.male : Icons.female,
      color: isMale ? const Color(0xFF1976D2) : const Color(0xFF8E24AA),
      size: 20.r,
    );
  }

  String _formatAge(DateTime birthdate) {
    final now = DateTime.now();
    final difference = now.difference(birthdate);
    final totalDays = difference.inDays;
    final years = totalDays / 365.0;

    if (years >= 1) {
      // Format to one decimal place (e.g., 1.5 year)
      final formattedYears = years.toStringAsFixed(1);
      // Remove trailing zero if it's a whole number
      final cleanYears = formattedYears.endsWith('.0')
          ? formattedYears.split('.')[0]
          : formattedYears;
      return '$cleanYears year${years < 2 ? '' : 's'}';
    } else {
      final months = (totalDays / 30).floor();
      if (months > 0) {
        return '$months month${months == 1 ? '' : 's'}';
      } else {
        return 'Less than a month';
      }
    }
  }
}

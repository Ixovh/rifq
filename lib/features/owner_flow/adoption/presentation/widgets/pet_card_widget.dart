import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';

class PetCardWidget extends StatelessWidget {
  final AddPetEntity pet;
  final VoidCallback? onTap;
  final String? location;

  const PetCardWidget({
    super.key,
    required this.pet,
    this.onTap,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 330.w,
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
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pet Name
                      Text(
                        pet.name,
                        style: context.body1.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                          color: context.neutral900,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 12.h),

                      // Location with icon
                      if (location != null) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16.r,
                              color: context.primary300,
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Text(
                                location!,
                                style: context.body2.copyWith(
                                  color: context.neutral600,
                                  fontSize: 14.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                      ],

                      // Age with calendar icon
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16.r,
                            color: context.primary300,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            '${_calculateAge(pet.birthdate)} ${_calculateAge(pet.birthdate) == 1 ? 'year' : 'years'}',
                            style: context.body2.copyWith(
                              color: context.neutral600,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Gender icon in bottom right
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: _buildGenderIcon(context),
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
    return Container(
      width: 32.w,
      height: 32.h,
      decoration: BoxDecoration(
        color: isMale
            ? const Color(0xFFE3F2FD)
            : const Color(0xFFFCE4EC), // Light blue/pink background
        shape: BoxShape.circle,
      ),
      child: Icon(
        isMale ? Icons.male : Icons.female,
        color: isMale ? const Color(0xFF1976D2) : const Color(0xFFC2185B),
        size: 20.r,
      ),
    );
  }

  int _calculateAge(DateTime birthdate) {
    final now = DateTime.now();
    int years = now.year - birthdate.year;
    if (now.month < birthdate.month ||
        (now.month == birthdate.month && now.day < birthdate.day)) {
      years--;
    }
    return years;
  }
}

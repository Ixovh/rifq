import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';

class AdoptionRequestCard extends StatelessWidget {
  final AdoptionRequestEntity request;
  final String petOwnerId;
  final String petId; // Add petId to identify which pet this request belongs to
  final AdoptionCubit cubit;

  const AdoptionRequestCard({
    super.key,
    required this.request,
    required this.petOwnerId,
    required this.petId,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: cubit.getUserName(userId: request.ownerId),
      builder: (context, snapshot) {
        final userName = snapshot.data ?? 'Unknown User';
        final userPhone = request.title; // Phone is stored in title field
        final isActive = request.status == 'active';
        final isAdopted = request.status == 'adopted';

        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: context.neutral100,

            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Color(0x3F656565),
                blurRadius: 4,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      userName,
                      style: context.body1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.primary300,
                      ),
                    ),
                  ),
                  if (!isActive)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: isAdopted
                            ? context.success.withValues(alpha: 0.2)
                            : context.error.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        isAdopted ? 'Accepted' : 'Rejected',
                        style: context.body3.copyWith(
                          color: isAdopted ? context.success : context.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.h),
              // Phone
              Row(
                children: [
                  Icon(Icons.phone, size: 16.r, color: context.neutral400),
                  SizedBox(width: 6.w),
                  Text(
                    userPhone,
                    style: context.body2.copyWith(color: context.neutral400),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              // Description
              Text(
                'Description:',
                style: context.body2.copyWith(
                  color: context.neutral400,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                request.description,
                style: context.body2.copyWith(color: context.neutral600),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12.h),
              // Action Buttons
              if (isActive)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Reject Button
                    ElevatedButton(
                      onPressed: () {
                        cubit.updateAdoptionRequestStatus(
                          requestId: request.id,
                          ownerId: petOwnerId,
                          status: 'reserved',
                          petId:
                              petId, // Pass petId to update the correct pet's cache
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.error,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Reject',
                        style: context.body2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // Accept Button
                    ElevatedButton(
                      onPressed: () {
                        cubit.updateAdoptionRequestStatus(
                          requestId: request.id,
                          ownerId: petOwnerId,
                          status: 'adopted',
                          petId:
                              petId, // Pass petId to update the correct pet's cache
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.success,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Accept',
                        style: context.body2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

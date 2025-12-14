import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/services_provider_flow/home/presentation/cubit/visit_details_cubit.dart';

class TreatmentInputSection extends StatelessWidget {
  final String reservationId;

  const TreatmentInputSection({super.key, required this.reservationId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VisitDetailsCubit, VisitDetailsState>(
      listener: (context, state) {
        if (state is VisitDetailsSendSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Treatment recommendations sent successfully',
                style: context.body1.copyWith(color: context.neutral100),
              ),
              backgroundColor: context.success,
            ),
          );
          context.pop();
        } else if (state is VisitDetailsSendError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<VisitDetailsCubit>();
        final isSending = state is VisitDetailsSending;

        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: context.neutral300, width: 1),
              ),
              child: TextField(
                controller: cubit.treatmentController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Enter treatment and recommendations...',
                  hintStyle: context.bodyMedium.copyWith(
                    color: context.neutral500,
                  ),
                  border: InputBorder.none,
                ),
                style: context.bodyMedium,
              ),
            ),
            SizedBox(height: 24.h),

            // Send Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSending
                    ? null
                    : () => cubit.sendTreatment(reservationId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  disabledBackgroundColor: context.neutral400,
                ),
                child: isSending
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: CircularProgressIndicator(
                          color: context.primary,
                          strokeWidth: 2,
                          backgroundColor: context.background,
                        ),
                      )
                    : Text(
                        'Send',
                        style: context.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}

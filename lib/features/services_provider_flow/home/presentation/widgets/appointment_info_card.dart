import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_theme.dart';

class AppointmentInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isTwoLine;
  final Color? statusColor;

  const AppointmentInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.isTwoLine,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24.sp, color: statusColor ?? context.primary),
          SizedBox(height: 8.h),
          Text(
            label,
            style: context.bodySmall.copyWith(color: context.neutral600),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),
          if (statusColor != null)
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: statusColor!.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  value.toLowerCase() == 'pending'
                      ? 'Pending'
                      : value.toLowerCase() == 'accepted'
                      ? 'Accepted'
                      : value.toLowerCase() == 'completed'
                      ? 'Completed'
                      : value.toLowerCase() == 'rejected'
                      ? 'Rejected'
                      : value,
                  style: context.bodySmall.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          else
            Flexible(
              child: Text(
                value,
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
                maxLines: isTwoLine ? 2 : 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

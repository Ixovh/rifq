import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/services_provider_flow/auth/presentation/cubit/provider_auth_cubit.dart';

class BuildServiceTypeOption extends StatelessWidget {
  const BuildServiceTypeOption({
    super.key,
    required this.context,
    required this.cubit,
    required this.id,
    required this.title,
    required this.icon,
    required this.isSelected,
  });

  final BuildContext context;
  final ProviderAuthCubit cubit;
  final int id;
  final String title;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => cubit.toggleServiceType(id),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? context.primary50 : Colors.white,
          border: Border.all(
            color: isSelected ? context.primary300 : context.neutral300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? context.primary300 : context.neutral600,
              size: 32.sp,
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: context.body1.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? context.primary400 : context.neutral800,
              ),
            ),
            const Spacer(),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? context.primary300 : context.neutral400,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}

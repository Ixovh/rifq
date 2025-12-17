import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/core/common/widgets/lottie_loading/lottie_loding.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdoptionTab extends StatelessWidget {
  const AdoptionTab({super.key});

  String _calculateAge(DateTime birthdate) {
    final now = DateTime.now();
    final difference = now.difference(birthdate);
    final years = difference.inDays / 365.25;

    // If less than 1 year, show age in months
    if (years < 1.0) {
      final months = (difference.inDays / 30.44).round();
      if (months < 1) {
        return '1 month';
      }
      return '$months month${months == 1 ? '' : 's'}';
    }

    // Format to one decimal place for years
    final formattedYears = years.toStringAsFixed(1);
    // Remove trailing zero if it's a whole number
    final cleanYears = formattedYears.endsWith('.0')
        ? formattedYears.substring(0, formattedYears.length - 2)
        : formattedYears;

    return '$cleanYears year';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdoptionCubit>();

    // Trigger load once using addPostFrameCallback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getAvailablePetsForAdoption();
    });

    return BlocConsumer<AdoptionCubit, AdoptionState>(
      listener: (context, state) {
        if (state is AdoptionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final availablePets = cubit.availablePets;

        if (state is AdoptionLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieLoding(),
                SizedBox(height: 16.h),
                Text(
                  'just a moment we will load available pets',
                  style: context.body2.copyWith(color: context.neutral300),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          );
        }

        if (state is AdoptionError && availablePets.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: context.body2.copyWith(color: context.neutral500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () =>
                      cubit.getAvailablePetsForAdoption(forceRefresh: true),
                  child: Text(
                    'Refresh',
                    style: context.body2.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        if (availablePets.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icon/logo.svg',
                  colorFilter: ColorFilter.mode(
                    context.neutral300,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'No pets available for adoption yet',
                  style: context.body2.copyWith(color: context.neutral300),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () =>
                      cubit.getAvailablePetsForAdoption(forceRefresh: true),
                  child: Text(
                    'Refresh',
                    style: context.body2.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            SizedBox(height: 16.h),
            Expanded(
              child: RefreshIndicator(
                color: context.primary,
                backgroundColor: context.background,
                onRefresh: () async {
                  await cubit.getAvailablePetsForAdoption(forceRefresh: true);
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.h);
                  },
                  itemCount: availablePets.length,
                  itemBuilder: (context, index) {
                    final pet = availablePets[index];
                    return InkWell(
                      onTap: () {
                        context.push(
                          Routes.petDetails,
                          extra: {'cubit': cubit, 'pet': pet},
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.r),
                        width: double.infinity,
                        height: 340.h,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F656565),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.network(
                                  pet.photoUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 185.h,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 185.h,
                                      color: context.neutral100,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/icon/logo.svg',
                                          colorFilter: ColorFilter.mode(
                                            context.neutral400,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 18.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  pet.name,
                                  style: context.h5.copyWith(
                                    color: context.neutral1000,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  pet.gender == 'male'
                                      ? Icons.male
                                      : Icons.female,
                                  color: context.secondary100,
                                  size: 25.r,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  pet.breed,
                                  style: context.body2.copyWith(
                                    color: context.neutral500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 16.r,
                                  color: context.primary300,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  _calculateAge(pet.birthdate),
                                  style: context.body2.copyWith(
                                    color: context.neutral500,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              width: 295.w,
                              height: 37.h,
                              decoration: BoxDecoration(
                                color: context.primary100,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'View Details',
                                    style: context.body2.copyWith(
                                      color: context.primary500,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: context.primary500,
                                    size: 16.r,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        );
      },
    );
  }
}

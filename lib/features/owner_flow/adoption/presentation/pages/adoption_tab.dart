import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';

class AdoptionTab extends StatelessWidget {
  const AdoptionTab({super.key});
  String _calculateAge(DateTime birthdate) {
    final now = DateTime.now();
    final difference = now.difference(birthdate);
    final years = difference.inDays / 365.25;

    // If less than 1 year, show age in months
    if (years < 1.0) {
      final months = (difference.inDays / 30.44)
          .round(); // Average days per month
      // If pet is less than 1 month old (in days or weeks), show as 1 month
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

    // Use singular "year" for all cases (matching the design)
    return '$cleanYears year';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdoptionCubit>()..getAvailablePetsForAdoption();

    return BlocConsumer<AdoptionCubit, AdoptionState>(
      listener: (context, state) {
        if (state is AdoptionError) {
          Text(
            state.message,
            style: context.body2.copyWith(color: context.error),
          );
        }
      },
      builder: (context, state) {
        if (state is AdoptionLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is AvailablePetsLoaded) {
          if (state.pets.isEmpty) {
            return Center(
              child: Text(
                'No pets found',
                style: context.body2.copyWith(color: context.neutral300),
              ),
            );
          }
          return Column(
            children: [
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.h);
                  },
                  itemCount: state.pets.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(16.r),
                      width: double.infinity,
                      height: 290.h,
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
                        crossAxisAlignment: .center,
                        children: [
                          Center(
                            child: Image.network(
                              state.pets[index].photoUrl,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 140.h,
                              errorBuilder: (context, error, stackTrace) {
                                return SvgPicture.asset(
                                  'assets/icon/logo.svg',
                                  colorFilter: ColorFilter.mode(
                                    context.neutral400,
                                    BlendMode.srcIn,
                                  ),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 18.h),

                          Row(
                            mainAxisAlignment: .center,
                            children: [
                              Text(
                                state.pets[index].name,
                                style: context.h5.copyWith(
                                  color: context.neutral1000,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                (state.pets[index].gender) == 'male'
                                    ? Icons.male
                                    : Icons.female,
                                color: context.secondary100,
                                size: 25.r,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                state.pets[index].breed,
                                style: context.body2.copyWith(
                                  color: context.neutral500,
                                ),
                              ),
                            ],
                          ),

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
                                _calculateAge(state.pets[index].birthdate),
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
                              mainAxisAlignment: .center,
                              children: [
                                // TODO: it will sends a request and this button will navigate to the see requests status screen
                                TextButton(
                                  onPressed: () {
                                    context.push(
                                      Routes.seeRequests,
                                      extra: {
                                        'cubit': cubit,
                                        'pet': state.pets[index],
                                      },
                                    );
                                  },
                                  child: Text(
                                    'send a request',
                                    style: context.body2.copyWith(
                                      color: context.primary500,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: context.primary500,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Center(
          child: Text(
            'No pets found',
            style: context.body2.copyWith(color: context.neutral300),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPetsTab extends StatelessWidget {
  const MyPetsTab({super.key});

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
    final cubit = context.read<AdoptionCubit>();
    final currentState = cubit.state;

    // Load data if we don't have the correct state for "my pets" tab
    // This prevents using cached data from "for adoption" tab which uses the same list
    // But don't reload if we just added a pet (PetAddedForAdoptionSuccess) - it will emit OfferedPetsLoaded
    if (currentState is! OfferedPetsLoaded &&
        currentState is! PetAddedForAdoptionSuccess &&
        currentState is! AdoptionLoading &&
        currentState is! AdoptionError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = cubit.state;
        if (state is! OfferedPetsLoaded &&
            state is! PetAddedForAdoptionSuccess &&
            state is! AdoptionLoading) {
          // Clear cache to remove any data from "for adoption" tab
          cubit.offeredForAdoptionPets.clear();
          cubit.getOfferedPetsForAdoption();
        }
      });
    }

    return BlocConsumer<AdoptionCubit, AdoptionState>(
      listener: (context, state) {
        if (state is PetRemovedFromAdoptionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Pet removed from adoption'),
              backgroundColor: context.success,
            ),
          );
        }
        if (state is PetAddedForAdoptionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Pet added for adoption successfully'),
              backgroundColor: context.success,
            ),
          );
        }
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
        // Use cached list only for states related to "my pets" tab
        // This prevents using data from "for adoption" tab (AvailablePetsLoaded)
        // Allows showing pets after adding them (PetAddedForAdoptionSuccess)
        final offeredPets =
            (state is OfferedPetsLoaded || state is PetAddedForAdoptionSuccess)
            ? cubit.offeredForAdoptionPets
            : [];

        if (state is AdoptionLoading && offeredPets.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: .center,
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
                  'just a moment we will load your pets',
                  style: context.body2.copyWith(color: context.neutral300),
                ),
                SizedBox(height: 16.h),
                CircularProgressIndicator(color: context.neutral300),
              ],
            ),
          );
        }

        if (state is AdoptionError && offeredPets.isEmpty) {
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
                  onPressed: () => cubit.getOfferedPetsForAdoption(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (offeredPets.isEmpty) {
          // Empty state if no pets are offered for adoption
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'you don\'t have any pet to offer for adoption yet',
                  style: context.body2.copyWith(color: context.neutral300),
                ),
                SizedBox(height: 16.h),
                AddingNewPet(
                  onTap: () {
                    context.push(Routes.selectPetForAdoption, extra: cubit);
                  },
                ),
              ],
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
                itemCount: offeredPets.length,
                itemBuilder: (context, index) {
                  return Container(
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
                    child: Dismissible(
                      direction: .endToStart,
                      key: Key(offeredPets[index].id),
                      onDismissed: (direction) {
                        cubit.removePetFromAdoption(
                          petId: offeredPets[index].id,
                          ownerId: offeredPets[index].ownerId,
                        );
                      },
                      background: Container(
                        color: context.error,
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Column(
                        crossAxisAlignment: .center,
                        children: [
                          Center(
                            child: Image.network(
                              offeredPets[index].photoUrl,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150.h,
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
                                offeredPets[index].name,
                                style: context.h5.copyWith(
                                  color: context.neutral1000,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                (offeredPets[index].gender) == 'male'
                                    ? Icons.male
                                    : Icons.female,
                                color: context.secondary100,
                                size: 25.r,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                offeredPets[index].breed,
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
                                _calculateAge(offeredPets[index].birthdate),
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
                                TextButton(
                                  onPressed: () {
                                    context.push(
                                      Routes.seeRequests,
                                      extra: {
                                        'cubit': cubit,
                                        'pet': offeredPets[index],
                                      },
                                    );
                                  },
                                  child: Text(
                                    'view requests',
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
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: AddingNewPet(
                onTap: () {
                  context.push(Routes.selectPetForAdoption, extra: cubit);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class AddingNewPet extends StatelessWidget {
  const AddingNewPet({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          color: context.neutral100,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Color(0x3F656565),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),

        child: Center(
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                'Add Pet for Adoption',
                style: context.body2.copyWith(color: context.primary),
              ),
              SizedBox(width: 4.w),
              Icon(Icons.add, color: context.primary),
            ],
          ),
        ),
      ),
    );
  }
}

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
      cubit.getOfferedPetsForAdoption();
    });

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
        final offeredPets = cubit.offeredForAdoptionPets;

        if (state is AdoptionLoading && offeredPets.isEmpty) {
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
                  onPressed: () =>
                      cubit.getOfferedPetsForAdoption(forceRefresh: true),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (offeredPets.isEmpty) {
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
                  final pet = offeredPets[index];
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
                      direction: DismissDirection.endToStart,
                      key: Key(pet.id),
                      onDismissed: (direction) {
                        cubit.removePetFromAdoption(
                          petId: pet.id,
                          ownerId: pet.ownerId,
                        );
                      },
                      background: Container(
                        color: context.error,
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.network(
                              pet.photoUrl,
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
                                TextButton(
                                  onPressed: () {
                                    context.push(
                                      Routes.seeRequests,
                                      extra: {'cubit': cubit, 'pet': pet},
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
            mainAxisAlignment: MainAxisAlignment.center,
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

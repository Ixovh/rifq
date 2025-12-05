import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/widgets/pet_card.dart';

class SelectPetForAdoptionScreen extends StatelessWidget {
  const SelectPetForAdoptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdoptionCubit>()..getMyPetsAndOffered();

    return BlocConsumer<AdoptionCubit, AdoptionState>(
      listener: (context, state) {
        if (state is PetAddedForAdoptionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${state.pet.name} added for adoption successfully',
              ),
              backgroundColor: context.success,
            ),
          );
          context.pop();
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
        if (state is AdoptionLoading) {
          return Scaffold(
            backgroundColor: context.background,
            appBar: AppBar(
              backgroundColor: context.background,
              title: Text(
                'Select Pet for Adoption',
                style: context.body1.copyWith(color: context.primary300),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: context.primary300),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            body: Center(
              child: CircularProgressIndicator(color: context.neutral300),
            ),
          );
        }

        if (state is AdoptionError) {
          return Scaffold(
            backgroundColor: context.background,
            appBar: AppBar(
              backgroundColor: context.background,
              title: Text(
                'Select Pet for Adoption',
                style: context.body1.copyWith(color: context.primary300),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: context.primary300),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.r,
                    color: context.neutral400,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    style: context.body2.copyWith(color: context.neutral500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => cubit.getMyPetsAndOffered(),
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is MyPetsAndOfferedLoaded) {
          // Filter out pets already offered
          final availablePets = state.allPets.where((pet) {
            return !state.offeredPets.any((offered) => offered.id == pet.id);
          }).toList();

          Widget body;

          if (state.allPets.isEmpty) {
            body = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets, size: 64.r, color: context.neutral400),
                  SizedBox(height: 16.h),
                  Text(
                    'You don\'t have any pets yet',
                    style: context.body2.copyWith(color: context.neutral500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (availablePets.isEmpty) {
            body = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.r, color: context.success),
                  SizedBox(height: 16.h),
                  Text(
                    'All your pets are already offered for adoption',
                    style: context.body2.copyWith(color: context.neutral500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            body = ListView.separated(
              padding: EdgeInsets.all(16.r),
              itemCount: availablePets.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final pet = availablePets[index];
                return PetCard(
                  pet: pet,
                  onTap: () {
                    cubit.addPetForAdoption(pet: pet);
                  },
                );
              },
            );
          }

          return Scaffold(
            backgroundColor: context.background,
            appBar: AppBar(
              backgroundColor: context.background,
              title: Text(
                'Select Pet for Adoption',
                style: context.body1.copyWith(color: context.primary300),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: context.primary300),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            body: body,
          );
        }

        return Scaffold(
          backgroundColor: context.background,
          appBar: AppBar(
            backgroundColor: context.background,
            title: Text(
              'Select Pet for Adoption',
              style: context.body1.copyWith(color: context.primary300),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: context.primary300),
              onPressed: () {
                context.pop();
              },
            ),
          ),
          body: Center(
            child: CircularProgressIndicator(color: context.neutral300),
          ),
        );
      },
    );
  }
}

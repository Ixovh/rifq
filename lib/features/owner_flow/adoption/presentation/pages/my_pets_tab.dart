import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/widgets/my_pet_card_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyPetsTab extends StatelessWidget {
  const MyPetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdoptionCubit>();
    return BlocBuilder<AdoptionCubit, AdoptionState>(
      builder: (context, state) {
        if (state is AdoptionLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AdoptionError) {
          return Center(
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
              ],
            ),
          );
        }

        if (state is PetRemovedFromAdoption) {
          // Refresh pets list after removal
          final currentUserId = Supabase.instance.client.auth.currentUser?.id;
          if (currentUserId != null) {
            cubit.getMyPets(currentUserId);
          }
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MyPetsLoaded) {
          if (state.pets.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pets_outlined,
                    size: 64.r,
                    color: context.neutral400,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No pets found',
                    style: context.body2.copyWith(color: context.neutral500),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 20.r),
                  itemCount: state.pets.length,
                  itemBuilder: (context, index) {
                    final pet = state.pets[index];
                    final ownerName = state.ownerNames[pet.ownerId];
                    final requestCount = state.requestCounts[pet.id] ?? 0;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: MyPetCardWidget(
                        pet: pet,
                        location: null, // No location field in database
                        requestCount: requestCount,
                        onTap: () {
                          context.push(
                            Routes.petDetails,
                            extra: {
                              'pet': pet,
                              'location': null, // No location field in database
                              'ownerName': ownerName,
                              'cubit': cubit, // Pass cubit for the new route
                              'isMyPet':
                                  true, // Flag to show remove from adoption option
                            },
                          );
                        },
                        onRequestsTap: () {
                          cubit.getAdoptionRequestsByPet(pet.id);
                        },
                      ),
                    );
                  },
                ),
              ),
              // Add Pet for Adoption Button
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to add pet for adoption screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primary100,
                    foregroundColor: context.primary300,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Pet for Adoption',
                        style: context.body2.copyWith(
                          color: context.primary300,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.add, size: 20.r, color: context.primary300),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        cubit.getMyPets(Supabase.instance.client.auth.currentUser!.id);

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.pets_outlined, size: 64.r, color: context.neutral400),
              SizedBox(height: 16.h),
              Text(
                'Loading your pets...',
                style: context.body2.copyWith(color: context.neutral500),
              ),
            ],
          ),
        );
      },
    );
  }
}

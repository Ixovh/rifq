import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/widgets/adoption_request_card.dart';

class SeeRequesetScreen extends StatelessWidget {
  final AddPetEntity pet;

  const SeeRequesetScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdoptionCubit>();
    final currentState = cubit.state;

    // Trigger initial load if we don’t have data yet and we’re not loading
    // Load adoption requests for the selected pet
    if (currentState is! AdoptionLoading &&
        currentState is! AdoptionError &&
        !(currentState is PetRequestsLoaded && currentState.petId == pet.id)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        cubit.getAdoptionRequestsForSpecificPet(
          petId: pet.id,
          ownerId: pet.ownerId,
        );
      });
    }
    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        backgroundColor: context.background,
        title: Text(
          'Adoption requests - ${pet.name}',
          style: context.body1.copyWith(color: context.primary300),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.primary300),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: BlocConsumer<AdoptionCubit, AdoptionState>(
        listener: (context, state) {
          if (state is AdoptionRequestStatusUpdated) {
            // Check if the request was accepted (pet ownership transferred)
            final isAccepted = state.request.status == 'adopted';

            if (isAccepted) {
              // Pet has been transferred, show success message and navigate back
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                    'Pet adoption request accepted! The pet has been transferred.',
                  ),
                  backgroundColor: context.success,
                  duration: const Duration(seconds: 3),
                ),
              );
              // Navigate back since the pet is no longer owned by this user
              Future.delayed(const Duration(milliseconds: 500), () {
                if (context.mounted) {
                  context.pop();
                }
              });
            } else {
              // Request was rejected, just reload requests
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Request status updated successfully'),
                  backgroundColor: context.success,
                ),
              );
              // Reload requests for this specific pet after status update
              // Only reload if the updated request belongs to this pet
              if (state.petId == null || state.petId == pet.id) {
                cubit.getAdoptionRequestsForSpecificPet(
                  petId: pet.id,
                  ownerId: pet.ownerId,
                  forceRefresh: true,
                );
              }
            }
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
          if (state is AdoptionError) {
            return Center(child: Text(state.message));
          }

          if (state is PetRequestsLoaded) {
            // Only show requests if they belong to the current pet
            if (state.petId != pet.id) {
              return Center(
                child: CircularProgressIndicator(color: context.primary300),
              );
            }
            return RefreshIndicator(
              color: context.primary,
              backgroundColor: context.background,
              onRefresh: () async {
                await cubit.getAdoptionRequestsForSpecificPet(
                  petId: pet.id,
                  ownerId: pet.ownerId,
                  forceRefresh: true,
                );
              },
              child: state.requests.isEmpty
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Center(
                          child: Text(
                            'No adoption requests found for this pet',
                            style: context.body2.copyWith(
                              color: context.neutral300,
                            ),
                          ),
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.all(16.r),
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 16.h);
                      },
                      itemCount: state.requests.length,
                      itemBuilder: (context, index) {
                        final request = state.requests[index];
                        return AdoptionRequestCard(
                          request: request,
                          petOwnerId: pet.ownerId,
                          petId: pet.id, // Pass petId to the card
                          cubit: cubit,
                        );
                      },
                    ),
            );
          }
          return Text('No requests found');
        },
      ),
    );
  }
}

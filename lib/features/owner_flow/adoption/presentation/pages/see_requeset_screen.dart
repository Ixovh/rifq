import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';

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
        currentState is! PetRequestsLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        cubit.getAdoptionRequestsForPet(petId: pet.id, ownerId: pet.ownerId);
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
      body: BlocBuilder<AdoptionCubit, AdoptionState>(
        builder: (context, state) {
          if (state is AdoptionLoading) {
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
          if (state is AdoptionError) {
            return Center(child: Text(state.message));
          }

          if (state is PetRequestsLoaded) {
            if (state.requests.isEmpty) {
              return Center(
                child: Text(
                  'No adoption requests found for this pet',
                  style: context.body2.copyWith(color: context.neutral300),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.requests.length,
              itemBuilder: (context, index) {
                return Text(state.requests[index].id);
              },
            );
          }
          return Text('No requests found');
        },
      ),
    );
  }
}

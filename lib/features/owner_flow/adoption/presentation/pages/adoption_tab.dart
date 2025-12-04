import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/widgets/pet_card_widget.dart';

class AdoptionTab extends StatelessWidget {
  const AdoptionTab({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdoptionCubit>();
    // TODO: Replace with data from DB/Cache via cubit/bloc
    // For now, using empty list - will be populated from state management
    final List<AddPetEntity> petsForAdoption = [];

    if (petsForAdoption.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pets_outlined, size: 64.r, color: context.neutral400),
            SizedBox(height: 16.h),
            Text(
              'No pets available for adoption',
              style: context.body2.copyWith(color: context.neutral500),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 20.r),
      itemCount: petsForAdoption.length,
      itemBuilder: (context, index) {
        final pet = petsForAdoption[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: PetCardWidget(
            pet: pet,
            location: 'Riyadh', // TODO: Get from pet data
            onTap: () {
              context.push(
                Routes.petDetails,
                extra: {
                  'pet': pet,
                  'location': null, // No location field in database
                  'ownerName': null, // TODO: Get owner name
                  'cubit': cubit, // Pass cubit for the new route
                  'isMyPet': false, // This is from adoption tab
                },
              );
            },
          ),
        );
      },
    );
  }
}

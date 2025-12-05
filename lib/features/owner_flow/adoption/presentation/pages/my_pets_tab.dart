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

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdoptionCubit>();
    final currentState = cubit.state;

    if (currentState is! OfferedPetsLoaded &&
        currentState is! AdoptionLoading &&
        currentState is! AdoptionError) {
      // Use addPostFrameCallback to avoid calling during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final state = cubit.state;
        // Double-check state hasn't changed before calling
        if (state is! OfferedPetsLoaded && state is! AdoptionLoading) {
          cubit.getOfferedPetsForAdoption();
        }
      });
    }

    return BlocBuilder<AdoptionCubit, AdoptionState>(
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
                Text(
                  'just a moment we will load your pets',
                  style: context.body2.copyWith(color: context.neutral300),
                ),
              ],
            ),
          );
        }
        if (state is AdoptionError) {
          return Center(child: Text(state.message));
        }
        if (state is OfferedPetsLoaded) {
          if (state.pets.isEmpty) {
            // Show empty state when no pets are offered for adoption
            return Center(
              child: Column(
                mainAxisAlignment: .center,
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
              Expanded(
                child: ListView.builder(
                  itemCount: state.pets.length,
                  itemBuilder: (context, index) {
                    return Text(state.pets[index].species);
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
        }

        return Center(
          child: Column(
            mainAxisAlignment: .center,
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

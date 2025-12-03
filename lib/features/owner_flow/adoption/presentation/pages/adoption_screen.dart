import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/widgets/pet_card_widget.dart';
import 'package:rifq/features/owner_flow/add_pet/domain/entities/add_pet_entity.dart';

class AdoptionScreen extends StatelessWidget {
  const AdoptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        backgroundColor: context.background,
        // TODO add profile icon
        title: Text(
          'Adoption',
          style: context.body1.copyWith(color: context.primary300),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 26.r),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                labelStyle: context.body2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.primary300,
                ),
                unselectedLabelColor: context.neutral200,
                indicatorColor: context.primary300,
                dividerColor: context.neutral200,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'for adoption'),
                  Tab(text: 'my pets'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // For Adoption Tab
                    _buildForAdoptionTab(context),
                    // TODO my pets will be here
                    Column(
                      mainAxisAlignment: .center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 340.h,
                          decoration: BoxDecoration(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForAdoptionTab(BuildContext context) {
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
            onTap: () {
              // TODO: Navigate to pet details screen
            },
          ),
        );
      },
    );
  }
}

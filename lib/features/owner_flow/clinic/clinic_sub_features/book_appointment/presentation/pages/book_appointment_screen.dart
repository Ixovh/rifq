import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/core/di/setup.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_info_card/presentation/cubit/pet_info_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../../core/common/widgets/lottie_loading/lottie_loding.dart';

class BookAppointmentScreen extends StatelessWidget {
  final ProviderItemsViewEntity entity;

  const BookAppointmentScreen({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId == null) {
      return const Scaffold(body: Center(child: Text('Please login first')));
    }

    return BlocProvider(
      create: (_) => getIt<PetInfoCubit>()..getPets(userId),
      child: _BookAppointmentView(entity: entity, userId: userId),
    );
  }
}

class _BookAppointmentView extends StatelessWidget {
  final ProviderItemsViewEntity entity;
  final String userId;

  const _BookAppointmentView({required this.entity, required this.userId});

  @override
  Widget build(BuildContext context) {
    final selectedPets = ValueNotifier<List<String>>([]);
    final selectedDate = ValueNotifier<DateTime?>(null);
    final selectedTime = ValueNotifier<String?>(null);

    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        title: const Text('Book Appointment'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------- Clinic Info --------
            Text(entity.providerName, style: context.h3),
            const SizedBox(height: 6),
            Text(entity.itemName, style: context.body2),

            const SizedBox(height: 24),

            // -------- Pets --------
            Text('Select Pet(s)', style: context.body1),
            const SizedBox(height: 12),
            //!!-------------------------------------------------
            //!------------------PET FETCHING !!-----------------------
            BlocBuilder<PetInfoCubit, PetInfoState>(
              builder: (context, state) {
                if (state is PetLoading) {
                  return const LottieLoding();
                }

                if (state is PetLoaded) {
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: state.pets.map((pet) {
                      return ValueListenableBuilder<List<String>>(
                        valueListenable: selectedPets,
                        builder: (_, selectedList, __) {
                          final isSelected = selectedList.contains(pet.id);

                          return GestureDetector(
                            onTap: () {
                              final list = [...selectedList];
                              isSelected
                                  ? list.remove(pet.id)
                                  : list.add(pet.id);
                              selectedPets.value = list;
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? context.primary50
                                          : Colors.grey.shade300,
                                      width: 2,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(pet.photoUrl),
                                  ),
                                  // child: CircleAvatar(
                                  //   radius: 30,
                                  //   backgroundImage: pet.photoUrl != null
                                  //       ? NetworkImage(pet.photoUrl!)
                                  //       : null,
                                  //   child: pet.photoUrl == null
                                  //       ? const Icon(Icons.pets)
                                  //       : null,
                                  // ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  pet.name,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? context.primary50
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                }

                return const SizedBox();
              },
            ),

            //!!-------------------------------------------------
            //!------------------PET FETCHING !!-----------------------
            const SizedBox(height: 24),

            // -------- Date --------
            Text('When are you visiting?', style: context.body1),
            const SizedBox(height: 12),

            ValueListenableBuilder<DateTime?>(
              valueListenable: selectedDate,
              builder: (_, date, _) {
                return OutlinedButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                      initialDate: DateTime.now(),
                    );
                    if (picked != null) selectedDate.value = picked;
                  },
                  child: Text(
                    date == null
                        ? 'Select Date'
                        : date.toString().split(' ').first,
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // -------- Time --------
            Text('Select Time', style: context.body1),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              children: ['4:00 PM', '5:00 PM', '6:00 PM', '7:00 PM', '8:00 PM', '9:00 PM','10:00 PM'].map((
                time,
              ) {
                return ValueListenableBuilder<String?>(
                  valueListenable: selectedTime,
                  builder: (_, value, _) {
                    return ChoiceChip(
                      label: Text(time),
                      selected: value == time,
                      onSelected: (_) => selectedTime.value = time,
                    );
                  },
                );
              }).toList(),
            ),

            const Spacer(),

            // -------- Continue Button --------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPets.value.isEmpty ||
                      selectedDate.value == null ||
                      selectedTime.value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please complete all fields'),
                      ),
                    );
                    return;
                  }

                  context.push(
                    Routes.bookingDetails,
                    extra: {
                      'entity': entity,
                      'petIds': selectedPets.value,
                      'date': selectedDate.value,
                      'time': selectedTime.value,
                    },
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primary50,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Continue', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

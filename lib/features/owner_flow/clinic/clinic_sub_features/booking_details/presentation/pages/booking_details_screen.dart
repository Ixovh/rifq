import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/booking_details/presentation/cubit/booking_details_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BookingDetailsScreen extends StatelessWidget {
  final ProviderItemsViewEntity entity;
  final List<String> petIds;
  final DateTime date;
  final String time;

  const BookingDetailsScreen({
    super.key,
    required this.entity,
    required this.petIds,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final notesController = TextEditingController();

    return BlocListener<BookingDetailsCubit, BookingDetailsState>(
      listener: (context, state) {
        if (state is BookingDetailsSuccess) {
          context.go(
            Routes.bookingConfirmed,
            extra: {
              'entity': entity,
              'petIds': petIds,
              'date': date,
              'time': time,
            },
          );
        }

        if (state is BookingDetailsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: context.background,
        appBar: AppBar(
          title: const Text('Booking Details'),
          backgroundColor: context.background,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //!----------PET----------
              Text('Pet', style: context.body1),
              const SizedBox(height: 8),
              Text('Selected pets: ${petIds.join(', ')}'),

              const SizedBox(height: 16),

              //!---------- APPOINTMENT ----------
              Text('Appointment', style: context.body1),
              const SizedBox(height: 8),
              Text('Clinic: ${entity.providerName}'),
              Text('Service: ${entity.itemName}'),
              Text('Date: ${date.toIso8601String().split("T").first}'),
              Text('Time: $time'),

              const SizedBox(height: 16),

              //!----------NOTES ----------
              Text('Notes (optional)', style: context.body1),
              const SizedBox(height: 8),
              TextField(
                controller: notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Add a note for your appointment',
                  border: OutlineInputBorder(),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final booking = ReservationOptEntity(
                      id: '',
                      userId: Supabase.instance.client.auth.currentUser!.id,
                      providerId: entity.providerId,
                      serviceItemId: entity.itemId,
                      petId:
                          petIds.first, //TODO: SHOULD ALLOW TO SELECT ALL PETS
                      startDate: date,
                      time: time,
                      status: 'pending',
                      notes: notesController.text.isEmpty
                          ? null
                          : notesController.text,
                      createdAt: DateTime.now(),
                    );

                    context.read<BookingDetailsCubit>().confirmBooking(booking);
                  },
                  child: const Text('Confirm Booking'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

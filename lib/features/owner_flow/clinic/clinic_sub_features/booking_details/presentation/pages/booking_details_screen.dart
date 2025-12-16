import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import 'package:rifq/core/theme/app_color.dart';
import 'package:rifq/core/theme/app_theme.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/booking_details/presentation/cubit/booking_details_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../../../core/common/widgets/button/custome_button_widgets.dart';
import '../../../../../../../core/di/setup.dart';
import '../../../../../pet_profile/sup_features/pet_info_card/presentation/cubit/pet_info_cubit.dart';
import '../widgets/pet_container_widgets.dart';


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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    },
    child: Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(title: const Text('Booking Details'),backgroundColor: context.background,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //!----------PET----------
          Row(
          children: [
          Image.asset("assets/images/pet_icone.png"),
          SizedBox(width: 10.h),
          Text('Pet', style: context.body1.copyWith(color: context.neutral800)),
          ],
        ),
          SizedBox(height: 10.h),
         BlocBuilder<PetInfoCubit, PetInfoState>(
              builder: (context, state) {
                if (state is PetLoading) {
                  return PetContainerWidgets(
                    width: 366.w,
                    height: 88.h,
                    radius: 12.r,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is PetLoaded) {
                  final selectedPets = state.pets.where((pet) => petIds.contains(pet.id)).toList();
                  return PetContainerWidgets(
                    width: 366.w,
                    height: 88.h,
                    radius: 12.r,
                    child: Row(
                      children: [
                        ...selectedPets.map((pet) {
                          final photoUrl = pet.photoUrl;
                          return Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 25.r,
                                  backgroundImage: photoUrl != null && photoUrl.isNotEmpty
                                      ? NetworkImage(photoUrl)
                                      : null,
                                  child: photoUrl == null || photoUrl.isEmpty
                                      ? const Icon(Icons.pets, size: 20)
                                      : null,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  pet.name, style: context.body2.copyWith(fontSize: 11.sp, color: context.neutral800, fontWeight: FontWeight.w500,
                                  ), maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),],
                            ),
                          );}),],),
                  );
                }return const SizedBox();
              },
            ),
          const SizedBox(height: 16),
              //
              //!---------- APPOINTMENT ----------
              Row(
                children: [
                  Image.asset("assets/images/calendar.png"),
                  SizedBox(width: 10.h),
                  Text('Appointment', style: context.body1.copyWith(color: context.neutral800)),
                ],
              ),
              SizedBox(height: 10.h),
              PetContainerWidgets(
                width: 366.w,
                height: 252.h,
                radius: 12.r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date', style: context.body2.copyWith(color: context.neutral600, fontSize: 12.sp,
                                ),),
                              SizedBox(height: 4.h),
                              Text('${date.day}/${date.month}/${date.year}', style: context.body1.copyWith(fontWeight: FontWeight.bold, color: context.neutral800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Time', style: context.body2.copyWith(color: context.neutral600, fontSize: 12.sp,),),
                              SizedBox(height: 4.h),
                              Text(time, style: context.body1.copyWith(fontWeight: FontWeight.bold, color: context.neutral800,
                              ),
                              ),],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Clinic', style: context.body2.copyWith(color: context.neutral600, fontSize: 12.sp,),
                              ),
                              SizedBox(height: 4.h),
                              Text(entity.providerName, style: context.body1.copyWith(fontWeight: FontWeight.bold, color: context.neutral800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(color: context.neutral300, thickness: 1),
                    Row(
                      children: [
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Service', style: context.body2.copyWith(color: context.neutral600, fontSize: 12.sp,),),
                              SizedBox(height: 4.h),
                              Text(entity.itemName, style: context.body1.copyWith(fontWeight: FontWeight.bold, color: context.neutral800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //!----------NOTES ----------
              const SizedBox(height: 16),
              Row(
                children: [
                  Image.asset("assets/images/menu-board.png"),
                  SizedBox(width: 10.h,),
                  Text('Notes', style: context.body1.copyWith(color: context.neutral800)),
                  SizedBox(width: 10.h,),
                  Text('(optional)', style: TextStyle(
                    color: AppColors.neutral800,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                  ),),
                ],
              ),
              SizedBox(height: 16.h,),
              TextField(
                controller: notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Color(0xFF949494)),
                  hintText: 'Add a note for your appointment',
                  border: OutlineInputBorder(),
                ),
              ),

              //!----------CONFIRM----------
              SizedBox(height: 40.h,),
              CustomeButtonWidgets(titel: 'Confirm Booking',
                onPressed: () {
                  final booking = ReservationOptEntity(
                    id: '',
                    userId: Supabase.instance.client.auth.currentUser!.id,
                    providerId: entity.providerId,
                    serviceItemId: entity.itemId,
                    petId: petIds.first, //SHOULD ALLOW TO SELECT ALL PETS
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
                buttonWidth: 366.w,
                buttonhight: 58.h,),
            ],
          ),
        ),
      ),
    ),
  );
}

}



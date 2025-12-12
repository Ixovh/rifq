import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/di/setup.dart';
import 'package:rifq/core/routes/base_routes.dart';
import 'package:rifq/core/theme/app_theme.dart';
import '../../../../../../../core/common/widgets/button/custome_button_widgets.dart';
import '../../../../../../../core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import '../../../../../../../core/shared/shared_in_owner_flow/shared/entities/reservation_opt_entity.dart';
import '../../../../../pet_profile/sup_features/pet_info_card/domain/usecase/pet_profile_usecase.dart';
import '../../../../../pet_profile/sup_features/pet_info_card/presentation/cubit/pet_info_cubit.dart';
import '../../../../../profile/domain/usecases/user_profile_usecase.dart';
import '../../../../../profile/presentation/cubit/profile_cubit.dart';
import '../../../payment/presentation/pages/confirm_and_pay_Screen.dart';
import '../../domain/usecase/booking_hotel_usecase.dart';
import '../cubit/booking_hotel_cubit.dart';
import '../widgets/date_time.dart';
import '../widgets/pet_name.dart';


class BookingHotel extends StatelessWidget {
  // تأدي غرض نفس ستيتفل
  final ValueNotifier<DateTime?> checkIn = ValueNotifier<DateTime?>(null);
  final ValueNotifier<DateTime?> checkOut = ValueNotifier<DateTime?>(null);
  final ProviderItemsViewEntity hotel;
  final String roomId;
  final ValueNotifier<List<String>> selectedPets = ValueNotifier([]);

  BookingHotel({super.key, required this.hotel, required this.roomId,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(getIt<UserProfileUsecase>())
            ..getUserProfile("e7c6dc83-bcf5-4c0a-9818-4fd1df190cf4"),
        ),
        BlocProvider(
          create: (context) => PetInfoCubit(getIt<PetProfileUsecase>()),
        ),
        BlocProvider(
          create: (context) => BookingHotelCubit(getIt<BookingHotelUsecase>()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Booking Details", style: context.body1.copyWith(color: context.primary300),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.all(16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocListener<ProfileCubit, ProfileState>(
                      listener: (context, state) {
                        if (state is ProfileLoaded) {
                          context.read<PetInfoCubit>().getPets(state.user.id);
                        }},
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileLoading) {
                            return Center(child: CircularProgressIndicator());}
                          if (state is ProfileLoaded) {
                            final user = state.user;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ${user.name}"),
                                SizedBox(height: 10.h),
                                Text("Email: ${user.email}"),
                              ],
                            );}
                          return Container();
                        },
                      ),
                    ),
                    SizedBox(height: 19.h),
                    BlocBuilder<PetInfoCubit, PetInfoState>(
                      builder: (context, state) {
                        if (state is PetLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (state is PetLoaded) {
                          return SizedBox(
                            height: 80.h,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 12.h),
                              children: state.pets.map((pet) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 12),
                                  child: ValueListenableBuilder<List<String>>(
                                    valueListenable: selectedPets,
                                    builder: (context, selected, _) {
                                      return PetNameCardinfoWidgets(
                                        pet: pet,
                                        isSelected: selected.contains(pet.id),
                                        onTap: () {
                                          if (selected.contains(pet.id)) {
                                            selectedPets.value = List.from(selected)..remove(pet.id);
                                          } else {
                                            selectedPets.value = List.from(selected)..add(pet.id);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }
                        return Container();
                      },),
                    SizedBox(height: 16.h),
                    Text("Service : ", style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text(hotel.itemName),
                        SizedBox(width: 20.w),
                        Text("${hotel.price} SAR"),
                      ],),
                    SizedBox(height: 20.h),
                    Text("Check-in Date",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    ValueListenableBuilder<DateTime?>(
                      valueListenable: checkIn,
                      builder: (context, value, _) {
                        return DateField(
                          label: "Select check-in date",
                          selectedDate: value,
                          onTap: () async {
                            final date = await pickDate(context);
                            if (date != null) {
                              checkIn.value = date;
                              if (checkOut.value != null &&
                                  checkOut.value!.isBefore(date)) {
                                checkOut.value = null;
                              }
                            }
                          },
                        );
                      },),
                    SizedBox(height: 20.h),
                    Text(
                      "Check-out Date", style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),),
                    SizedBox(height: 11.h),
                    ValueListenableBuilder<DateTime?>(
                      valueListenable: checkOut,
                      builder: (context, value, _) {
                        return DateField(
                          label: "Select check-out date",
                          selectedDate: value,
                          onTap: () async {
                            final checkInDate = checkIn.value;
                            final date = await pickDate(context);
                            if (date != null) {
                              if (checkInDate != null &&
                                  date.isBefore(checkInDate)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Check-out must be after check-in"),),);
                                return;
                              }
                              checkOut.value = date;
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 60.h),
                    SizedBox(height: 60.h),
                    CustomeButtonWidgets(
                      titel: 'Book Now',
                      onPressed: () async {
                        final profileState = context.read<ProfileCubit>().state;
                        if (profileState is! ProfileLoaded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User data is not loaded yet')),
                          );
                          return;
                        }
                        if (selectedPets.value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select at least one pet')),
                          );
                          return;
                        }
                        if (checkIn.value == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select check-in date')),);
                          return;
                        }
                        final bookingCubit = context.read<BookingHotelCubit>();
                        for (String petId in selectedPets.value) {
                          final booking = ReservationOptEntity(
                            id: '',
                            userId: profileState.user.id,
                            providerId: hotel.providerId,
                            serviceItemId: roomId,
                            petId: petId,
                            startDate: checkIn.value!,
                            endDate: checkOut.value,
                            status: 'pending',
                            notes: '',
                            createdAt: DateTime.now(),
                            time: null,
                          );
                          await bookingCubit.createBooking(booking);
                        }
                        final state = bookingCubit.state;                        // استماع للنتيجة
                        if (state is BookingSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Booking saved successfully!')),
                          );
                          context.push(Routes.confirmandpay, extra:{
                            'booking':state.booking,
                            'hotel':hotel,
                            'selectedPets':selectedPets.value,
                          });
                        } else if (state is BookingError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Booking failed: ${state.message}')),
                          );
                        }},
                      buttonWidth: 366.w,
                      buttonhight: 58.h,)
                  ],),
              ),),);}),);}}








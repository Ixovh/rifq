import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/common/choose_path/presentation/pages/choose_path_screen.dart';
import 'package:rifq/core/common/splash/presentation/pages/splash_screen.dart';
import 'package:rifq/core/di/setup.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import 'package:rifq/core/shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';
import 'package:rifq/features/owner_flow/add_pet/presentation/pages/add_pet_screen.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/pages/adoption_screen.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/pages/pet_details_screen.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/pages/see_requeset_screen.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/pages/select_pet_for_adoption_screen.dart';
import 'package:rifq/features/owner_flow/ai/presentation/pages/ai_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/auth_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/otp_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/reset_password_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/sends_to_email_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/welcome_screen.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/book_appointment/presentation/pages/book_appointment_screen.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/booking_details/presentation/cubit/booking_details_cubit.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/booking_details/presentation/pages/booking_details_screen.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/clinic_details/presentation/pages/clinic_details_screen.dart';
import 'package:rifq/features/owner_flow/clinic/clinic_sub_features/confirmation/presentation/pages/confirmation_screen.dart';

import 'package:rifq/features/owner_flow/hotel/data/model/hotel_model.dart';
import 'package:rifq/features/owner_flow/hotel/presentation/cubit/hotel_cubit.dart';
import 'package:rifq/features/owner_flow/hotel/presentation/pages/hotel_details_screen.dart';

import 'package:rifq/features/owner_flow/clinic/presentation/pages/clinic_screen.dart';

import 'package:rifq/features/owner_flow/hotel/presentation/pages/hotel_home_screen.dart';
import 'package:rifq/features/owner_flow/hotel/sup_feauter/booking_hotel/presentation/pages/booking_hotel.dart';
import 'package:rifq/features/owner_flow/nav/presentation/cubit/nav_cubit.dart';
import 'package:rifq/features/owner_flow/nav/presentation/pages/nav_screen.dart';
import 'package:rifq/features/owner_flow/onbording/presentation/pages/onbording_screen.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/edit_pet_profile/presentaion/pages/edit_pet_profile.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_info_card/presentation/cubit/pet_info_cubit.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/entity/pet_profile_records_entity.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_profile_health_record/presentaion/pages/PetProfile_HealthAppointment_Screen.dart';
import 'package:rifq/features/owner_flow/profile/presentation/cubit/profile_cubit.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/edit_profile_screen.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/profile_screen.dart';

abstract class Routes {
  static String splash = '/';
  static String choosePath = '/choosePath';
  static String ownerOnboarding = '/ownerOnboarding';
  static String welcomeScreen = '/welcomeScreen';
  // static String providerOnboarding = '/providerOnboarding';
  static String auth = '/auth';
  static String otpScreen = '/otp';
  static String home = '/home';
  static String profile = '/userprofile';
  static String editprofile = '/usereditprofile';
  static String petprofile = '/petprofi';
  static String editpetprofile = '/editpetprofi';
  static String sendsToEmail = '/sendsToEmail';
  static String resetPassword = '/resetPassword';
  static String navbar = '/navbar';
  static String addpet = '/addpet';

  static String aiScreen = '/aiScreen';
  static String healthScreen = '/healthScreen';

  static String hotelScreen = '/hotelScreen';
  // static String adoptionScreen = '/adoptionScreen';

  static String adoption = '/adoption';
  static String selectPetForAdoption = '/selectPetForAdoption';
  static String seeRequests = '/seeRequests';
  static String petDetails = '/petDetails';

  static String hotel = '/HotelHome';
  static String detailsHotel = '/DetailsHotel';
  static String bookingHotel = '/BookingHotel';
  static String healthRecourdpet = '/HealthRecourdpet';

  static String clinicDetails = '/clinicDetails';
  static const bookAppointment = '/book-appointment';
  static const bookingDetails = '/bookingDetails';
  static const bookingConfirmed = '/bookingConfirmed';


  static final routers = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),

      GoRoute(
        path: choosePath,
        builder: (context, state) => ChoosePathScreen(),
      ),

      GoRoute(
        path: ownerOnboarding,
        builder: (context, state) => OnbordingScreen(),
      ),

      GoRoute(
        path: welcomeScreen,
        builder: (context, state) => WelcomeScreen(),
      ),

      //------//
      //------//
      //------//
      //------//
      GoRoute(
        path: auth,
        builder: (context, state) {
          return AuthScreen();
        },
      ),
      //------//
      //------//
      //------//
      //------//
      GoRoute(
        path: otpScreen,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return BlocProvider.value(
            value: data['cubit'] as AuthCubit,
            child: OtpScreen(isResetPassword: data["isPassword"] as bool),
          );
        },
      ),
      //------//
      //------//
      //------//
      //------//
      GoRoute(
        path: sendsToEmail,
        builder: (context, state) {
          return BlocProvider.value(
            value: state.extra as AuthCubit,
            child: SendsToEmailScreen(),
          );
        },
      ),
      //------//
      //------//
      //------//
      //------//
      GoRoute(
        path: resetPassword,
        builder: (context, state) {
          return BlocProvider.value(
            value: state.extra as AuthCubit,
            child: ResetPasswordScreen(),
          );
        },
      ),

      //------//
      //------//
      //------//
      //------//
      // GoRoute(
      //   path: home,
      //   builder: (context, state) {
      //     return HomeScreen();
      //   },
      // ),
      // GoRoute(path: profile, builder: (context, state) => ProfileScreen()),
      // GoRoute(
      //   path: profile,
      //   name: Routes.profile,
      //   builder: (context, state) {
      //     final userId = state.extra as String;
      //     return ProfileScreen(userId: userId);
      //   },
      // ),
      GoRoute(
        path: editprofile,
        builder: (context, state) {
          final cubit = state.extra as ProfileCubit;
          return BlocProvider.value(value: cubit, child: EditProfileScreen());
        },
      ),
      GoRoute(
        path: navbar,
        builder: (context, state) {
          return BlocProvider(create: (_) => NavCubit(), child: NavScreen());
        },
      ),

      GoRoute(path: addpet, builder: (context, state) => AddPetScreen()),

      GoRoute(
        path: editpetprofile,
        builder: (context, state) {
          final pet = state.extra;
          print(pet.toString());
          if (pet is! PetProfileEntity) {
            return Center(child: Text("data"));
          }
          return EditPetProfileScreen(pet: pet);
        },
      ),

      GoRoute(
        path: hotel,
        builder: (context, state) {
          return HotelHomeScreen();
        },
      ),

      //       GoRoute(
      //   path: detailsHotel,
      //   builder: (context, state) {
      //     // map لاني ارسل اكثر من قيمه
      //     final extra = state.extra as Map<String, dynamic>;
      //     final hotel = extra['hotel'] as HotelModel;
      //     final cubit = extra['cubit'] as HotelCubit;
      //     return BlocProvider.value(
      //       value: cubit,
      //       child: HotelDetailsScreen(hotel: hotel),
      //     );
      //   },
      // ),
      GoRoute(path: addpet, builder: (context, state) => AddPetScreen()),

      GoRoute(path: aiScreen, builder: (context, state) => AiScreen()),
      GoRoute(path: healthScreen, builder: (context, state) => ClinicScreen()),

      GoRoute(
        path: hotelScreen,
        builder: (context, state) => HotelHomeScreen(),
      ),

      // GoRoute(path: adoptionScreen, builder: (context, state) => Ad()),
      GoRoute(
        path: adoption,
        builder: (context, state) {
          return AdoptionScreen();
        },
      ),
      GoRoute(
        path: selectPetForAdoption,
        builder: (context, state) {
          return BlocProvider.value(
            value: state.extra as AdoptionCubit,
            child: SelectPetForAdoptionScreen(),
          );
        },
      ),
      GoRoute(
        path: seeRequests,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return BlocProvider.value(
            value: data['cubit'] as AdoptionCubit,
            child: SeeRequesetScreen(pet: data['pet']),
          );
        },
      ),
      GoRoute(
        path: petDetails,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return BlocProvider.value(
            value: data['cubit'] as AdoptionCubit,
            child: PetDetailsScreen(pet: data['pet']),
          );
        },
      ),
      GoRoute(path: profile, builder: (context, state) => ProfileScreen()),
      //------//
      //------//
      //------//
      //------//
      GoRoute(
        path: editprofile,
        builder: (context, state) {
          final cubit = state.extra as ProfileCubit;
          return BlocProvider.value(value: cubit, child: EditProfileScreen());
        },
      ),

      //------//
      //------//
      //------//
      //------//
      GoRoute(
        path: hotel,
        builder: (context, state) {
          return HotelHomeScreen();
        },
      ),

      //------//
      //------//
      //------//
      GoRoute(
        path: detailsHotel,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final hotel = extra['hotel'] as ProviderEntity;
          final cubit = extra['cubit'] as HotelCubit;
          return BlocProvider.value(
            value: cubit,
            child: HotelDetailsScreen(hotel: hotel),
          );
        },
      ),

      //------//
      //------//
      //------//
      GoRoute(
        path: bookingHotel,
        builder: (context, state) {
          final extra =
              state.extra as Map<String, dynamic>; // نجيب البيانات اللي مررناها
          final hotel = extra['hotel'] as ProviderItemsViewEntity;
          final roomId = extra['roomId'] as String;
          return BookingHotel(hotel: hotel, roomId: roomId);
        },
      ),

      //------//
      //------//
      //------//
      //------//
      GoRoute(
        path: Routes.healthRecourdpet,
        builder: (context, state) {
          final pet = state.extra as PetEntity;
          return PetHealthAndAppointmentScreen(pet: pet);
        },
      ),

      //------//
      //------//
      //------//
      GoRoute(
        path: Routes.clinicDetails,
        builder: (_, state) =>
            ClinicDetailsScreen(providerId: state.extra as String),
      ),

      //------//
      //------//
      //------//
      GoRoute(
        path: Routes.bookAppointment,
        builder: (context, state) {
          // final extra = state.extra as Map<String, dynamic>;
          // final entity = extra['entity'] as ProviderItemsViewEntity;
          final entity = state.extra as ProviderItemsViewEntity;
          // final entity = extra['entity'] as ReservationOptEntity;
          // final userId = extra['userId'] as String;

          return BookAppointmentScreen(entity: entity);
        },
      ),

      // GoRoute(
      //   path: Routes.bookingDetails,
      //   builder: (context, state) {
      //     final extra = state.extra as Map<String, dynamic>;

      //     return BookingDetailsScreen(
      //       entity: extra['entity'],
      //       petIds: List<String>.from(extra['petIds']),
      //       date: extra['date'],
      //       time: extra['time'],
      //     );
      //   },
      // ),

      GoRoute(
  path: Routes.bookingDetails,
  builder: (context, state) {
    final extra = state.extra as Map<String, dynamic>;

    return BlocProvider(
      create: (_) => getIt<BookingDetailsCubit>(),
      child: BookingDetailsScreen(
        entity: extra['entity'],
        petIds: List<String>.from(extra['petIds']),
        date: extra['date'],
        time: extra['time'],
      ),
    );
  },
),


      //------//
      //------//
      //------//
      GoRoute(
        path: Routes.bookingConfirmed,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;

          return ConfirmationScreen(
            entity: extra['entity'] as ProviderItemsViewEntity,
            petIds: List<String>.from(extra['petIds'] as List),
            date: extra['date'] as DateTime,
            time: extra['time'] as String,
          );
        },
      ),

      // GoRoute(
      //   path: confirmandpay,
      //   builder: (context, state) {
      //     final extra = state.extra as Map<String, dynamic>?;

      //     final booking = extra?['booking'] as ReservationOptEntity?;
      //     final hotel = extra?['hotel'] as ProviderItemsViewEntity?;
      //     final selectedPets = extra?['selectedPets'] as List<String>?;
      //     if (booking == null || hotel == null || selectedPets == null) {
      //       return Scaffold(body: Center(child: Text("Data missing")));
      //     }
      //     return ConfirmAndPayScreen(
      //       booking: booking,
      //       hotel: hotel,
      //       selectedPets: selectedPets,
      //     );
      //   },
      // ),

      ///-----///
      ///-----///
      ///-----///

      //  GoRoute(
      //   path: paymentscreen,
      //   builder: (context, state) {
      //     final extra = state.extra as Map<String, dynamic>;
      //     return PaymentScreen(
      //       amount: extra['amount'] as int,
      //       bookingId: extra['bookingId'] as String,
      //     );
      //   },
      // ),

      ///-----///
      ///-----///
      ///-----///
      ///final extra = state.extra as Map<String, dynamic>;
      // final entity = extra['entity'] as ProviderItemsViewEntity;
      // final petIds = extra['petIds'] as List<String>;
      // final date = extra['date'] as DateTime;
      // final time = extra['time'] as String;
      ///-----///
      ///-----///
      ///-----///

      //    GoRoute(
      //   path: successfullpay,
      //   builder: (context, state) => PaymentSuccesfull(),
      // ),
    ],
  );
}

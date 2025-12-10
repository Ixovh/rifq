import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/features/owner_flow/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/auth_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/otp_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/reset_password_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/sends_to_email_screen.dart';
import 'package:rifq/features/owner_flow/onbording/presentation/pages/onbording_screen.dart';
import 'package:rifq/features/owner_flow/profile/presentation/cubit/profile_cubit.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/edit_profile_screen.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/home_screen.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/profile_screen.dart';
import '../../features/owner_flow/hotel/presentation/cubit/hotel_cubit.dart';
import '../../features/owner_flow/hotel/presentation/pages/hotel_details_screen.dart';
import '../../features/owner_flow/hotel/presentation/pages/hotel_home_screen.dart';
import '../../features/owner_flow/hotel/sup_feauter/booking_hotel/presentation/pages/booking_hotel.dart';
import '../../features/owner_flow/pet_profile/sup_features/edit_pet_profile/domain/usecase/edit_pet_profile_usecase.dart';
import '../../features/owner_flow/pet_profile/sup_features/edit_pet_profile/presentaion/cubit/edit_pet_profile_cubit.dart';
import '../../features/owner_flow/pet_profile/sup_features/edit_pet_profile/presentaion/pages/edit_pet_profile.dart';
import '../../features/owner_flow/pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';
import '../../features/owner_flow/pet_profile/sup_features/pet_profile_health_record/domain/entity/pet_profile_records_entity.dart';
import '../../features/owner_flow/pet_profile/sup_features/pet_profile_health_record/presentaion/pages/PetProfile_HealthAppointment_Screen.dart';
import '../shared/shared_in_owner_flow/shared/entities/provider_entity.dart';
import '../shared/shared_in_owner_flow/shared/entities/provider_items_view_entity.dart';


abstract class Routes {
  static String init = '/';
  static String auth = '/auth';
  static String otpScreen = '/otp';
  static String home = '/home';
  static String onbording = '/onbording';
  static String profile = '/userprofile';
  static String editprofile = '/usereditprofile';
  static String petprofile = '/petprofi';
  static String editpetprofile = '/editpetprofi';
  static String sendsToEmail = '/sendsToEmail';
  static String resetPassword = '/resetPassword';
  static String hotel = '/HotelHome';
  static String detailsHotel = '/DetailsHotel';
  static String bookingHotel = '/BookingHotel';
  static String healthRecourdpet = '/HealthRecourdpet';





  static final routers = GoRouter(
    initialLocation: hotel,
    routes: [
      GoRoute(
        path: onbording,
        builder: (context, state) => OnbordingScreen(),
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
            child: OtpScreen(isResetPassword: data["isPassword"] as bool,),
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
      GoRoute(
        path: home,
        builder: (context, state) {
          return HomeScreen();
        },
      ),
	GoRoute(
        path: profile,
        builder: (context, state) => ProfileScreen(),
      ),
      //------//
      //------//
      //------//
      //------//
      GoRoute(
        path: editprofile,
        builder: (context, state) {
          final cubit = state.extra as ProfileCubit;
          return BlocProvider.value(
            value: cubit,
            child: EditProfileScreen(),
          );
        },
      ),
      //------//
      //------//
      //------//
      //------//


      GoRoute(
        path: editpetprofile,
        builder: (context, state) {
          final pet = state.extra;
          if (pet is! PetProfileEntity) {
            return Center(child: Text("No pet data"));
          }
          return BlocProvider(
            create: (context) => EditPetProfileCubit(
              GetIt.I.get<EditPetProfileUsecase>(),
              pet: pet,
            ),
            child: EditPetProfileScreen(pet: pet),
          );
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
          final extra = state.extra as Map<String, dynamic>; // نجيب البيانات اللي مررناها
          final hotel = extra['hotel'] as ProviderItemsViewEntity;
          final roomId = extra['roomId'] as String;
          return BookingHotel(
            hotel: hotel,
            roomId: roomId,
          );
        },
      ),

      // GoRoute(
      //   path: bookingHotel,
      //   builder: (context, state) {
      //     // final pet = state.extra as PetProfileEntity;
      //     return BookingHotel();
      //   },
      // ),
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
    ],
  );
}


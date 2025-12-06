import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/common/choose_path/presentation/pages/choose_path_screen.dart';
import 'package:rifq/core/common/splash/presentation/pages/splash_screen.dart';
import 'package:rifq/features/owner_flow/add_pet/presentation/pages/add_pet_screen.dart';
import 'package:rifq/features/owner_flow/ai/presentation/pages/ai_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/auth_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/otp_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/reset_password_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/sends_to_email_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/welcome_screen.dart';

import 'package:rifq/features/owner_flow/hotel/data/model/hotel_model.dart';
import 'package:rifq/features/owner_flow/hotel/presentation/cubit/hotel_cubit.dart';
import 'package:rifq/features/owner_flow/hotel/presentation/pages/hotel_details_screen.dart';

import 'package:rifq/features/owner_flow/health/presentation/pages/health_screen.dart';

import 'package:rifq/features/owner_flow/hotel/presentation/pages/hotel_home_screen.dart';
import 'package:rifq/features/owner_flow/nav/presentation/cubit/nav_cubit.dart';
import 'package:rifq/features/owner_flow/nav/presentation/pages/nav_screen.dart';
import 'package:rifq/features/owner_flow/onbording/presentation/pages/onbording_screen.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/edit_pet_profile/presentaion/pages/edit_pet_profile.dart';
import 'package:rifq/features/owner_flow/pet_profile/sup_features/pet_info_card/domain/entity/pet_entity.dart';
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

    static String hotel = '/HotelHome';
  static String detailsHotel = '/DetailsHotel';


  static String aiScreen = '/aiScreen';
  static String healthScreen = '/healthScreen';

  static String hotelScreen = '/hotelScreen';
  static String adoptionScreen = '/adoptionScreen';

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
      GoRoute(
        path: profile,
        name: Routes.profile,
        builder: (context, state) {
          final userId = state.extra as String;
          return ProfileScreen(userId: userId);
        },
      ),

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

            GoRoute(
        path: detailsHotel,
        builder: (context, state) {
          // map لاني ارسل اكثر من قيمه
          final extra = state.extra as Map<String, dynamic>;
          final hotel = extra['hotel'] as HotelModel;
          final cubit = extra['cubit'] as HotelCubit;
          return BlocProvider.value(
            value: cubit,
            child: HotelDetailsScreen(hotel: hotel),
          );
        },
      ),

      GoRoute(path: addpet, builder: (context, state) => AddPetScreen()),

      GoRoute(path: aiScreen, builder: (context, state) => AiScreen()),
      GoRoute(path: healthScreen, builder: (context, state) => HealthScreen()),

      GoRoute(
        path: hotelScreen,
        builder: (context, state) => HotelHomeScreen(),
      ),
      // GoRoute(path: adoptionScreen, builder: (context, state) => Ad()),

    ],
  );
}

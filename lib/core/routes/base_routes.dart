import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import '../../features/owner_flow/hotel/presentation/pages/hotel_home_screen.dart';
import '../../features/owner_flow/pet_profile/sup_features/edit_pet_profile/presentaion/pages/edit_pet_profile.dart';
import '../../features/owner_flow/pet_profile/sup_features/pet_info_card/domain/entity/pet_profile_entity.dart';

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
          print(pet.toString());
          if (pet is! PetProfileEntity) {
            return Center(child: Text("data"));
          }
          return EditPetProfileScreen(pet: pet);
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

      // GoRoute(
      //   path: editpetprofile,
      //   builder: (context, state) {
      //     final pet = state.extra as PetProfileEntity;
      //     return EditPetProfileScreen(pet: pet);
      //   },
      // ),


      // GoRoute(
      //   path: editpetprofile,
      //   builder: (context, state) {
      //     final pet = state.extra as PetProfileEntity;
      //     return EditPetProfileScreen(pet: pet);
      //   },
      // ),
    ],
  );
}


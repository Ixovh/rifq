import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/core/common/choose_path/presentation/pages/choose_path_screen.dart';
import 'package:rifq/core/common/splash/presentation/pages/splash_screen.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/cubit/adoption_cubit.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/pages/adoption_screen.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/pages/see_requeset_screen.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/pages/select_pet_for_adoption_screen.dart';
import 'package:rifq/features/owner_flow/adoption/presentation/pages/pet_details_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/auth_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/otp_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/reset_password_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/sends_to_email_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/welcome_screen.dart';
import 'package:rifq/features/owner_flow/onbording/presentation/pages/onbording_screen.dart';
import 'package:rifq/features/owner_flow/profile/presentation/cubit/profile_cubit.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/edit_profile_screen.dart';
import 'package:rifq/home_screen.dart';
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
  static String adoption = '/adoption';
  static String selectPetForAdoption = '/selectPetForAdoption';
  static String seeRequests = '/seeRequests';
  static String petDetails = '/petDetails';

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
      GoRoute(
        path: home,
        builder: (context, state) {
          return HomeScreen();
        },
      ),
      //------//
      //------//
      //------//
      //------//
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
      GoRoute(
        path: editprofile,
        builder: (context, state) {
          final cubit = state.extra as ProfileCubit;
          return BlocProvider.value(value: cubit, child: EditProfileScreen());
        },
      ),
    ],
  );
}

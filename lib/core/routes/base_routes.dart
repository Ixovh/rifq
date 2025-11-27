import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/features/owner_flow/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/auth_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/otp_screen.dart';
import 'package:rifq/features/owner_flow/onbording/presentation/pages/onbording_screen.dart';
import 'package:rifq/features/owner_flow/profile/presentation/cubit/profile_cubit.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/edit_profile_screen.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/home_screen.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/profile_screen.dart';

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


  static final routers = GoRouter(
    initialLocation: profile,
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
          return BlocProvider.value(
            value: state.extra as AuthCubit,
            child: OtpScreen(),
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
    ],
  );
}


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rifq/features/owner_flow/auth/presentation/cubit/auth_cubit.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/auth_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/otp_screen.dart';
import 'package:rifq/features/owner_flow/auth/presentation/pages/welcome_screen.dart';
import 'package:rifq/features/owner_flow/profile/presentation/pages/home_screen.dart';

abstract class Routes {
  static String init = '/';
  static String auth = '/auth';
  static String otpScreen = '/otp';
  static String home = '/home';

  static final routers = GoRouter(
    initialLocation: init,
    routes: [
      GoRoute(
        path: init,
        builder: (context, state) {
          return WelcomeScreen();
        },
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
    ],
  );
}

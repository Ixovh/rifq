// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../features/owner_flow/onbording/presentation/pages/onbording_screen.dart';
// import '../../features/owner_flow/profile/presentation/cubit/profile_cubit.dart';
// import '../../features/owner_flow/profile/presentation/pages/edit_profile_screen.dart';
// import '../../features/owner_flow/profile/presentation/pages/profile_screen.dart';
//
// abstract class Routs{
//   static String onbording = '/onbording';
//   static String profile = '/userprofile';
//   static String editprofile = '/usereditprofile';
//   static String petprofile = '/petprofi';
//   static String editpetprofile = '/editpetprofi';
//
//   static final routers = GoRouter(
//   initialLocation: profile,
//   routes: [
//     GoRoute(path: onbording, builder: (context, state) => OnbordingScreen()),
//     GoRoute(path: profile, builder: (context, state) => ProfileScreen()),
//   GoRoute(
//   path: editprofile,
//   builder: (context, state) {
//   final cubit = state.extra as ProfileCubit;
//   return BlocProvider.value(
//   value: cubit,
//   child: EditProfileScreen(),
//   );
//   },    // GoRoute(path: petprofile, builder: (context, state) => OnbordingScreen()),
//     // GoRoute(path: editpetprofile, builder: (context, state) => OnbordingScreen()),
//
//
//   )]);
//
//
//
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/owner_flow/onbording/presentation/pages/onbording_screen.dart';
import '../../features/owner_flow/profile/presentation/cubit/profile_cubit.dart';
import '../../features/owner_flow/profile/presentation/pages/edit_profile_screen.dart';
import '../../features/owner_flow/profile/presentation/pages/profile_screen.dart';

abstract class Routs {
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
      // GoRoute(path: petprofile, builder: (context, state) => OnbordingScreen()),
      // GoRoute(path: editpetprofile, builder: (context, state) => OnbordingScreen()),
    ],
  );
}